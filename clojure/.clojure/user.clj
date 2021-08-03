(ns user
  (:require [clojure.java.classpath :as classpath]
            [clojure.java.io :as io]
            [cider.nrepl]
            [nrepl.middleware]
            [nrepl.server :refer [start-server stop-server default-handler]]))

(defn- static-classpath-dirs
  []
  (mapv #(.getCanonicalPath  %) (classpath/classpath-directories)))

(defn user-clj-paths
  []
  (->> (static-classpath-dirs)
    (map #(io/file % "user.clj"))
    (filter #(.exists %))))

(defn load-user!
  [f]
  (try
    (prn (str "Loading " f))
    (load-file (str f))
    (catch Exception e
      (binding [*out* *err*]
        (printf "WARNING: Exception while loading %s\n" f)
        (prn e)))))

(defn load-all-user!
  []
  (let [paths (user-clj-paths)]
    (prn (str "Load " (first paths)))
    (doall
      (map load-user! (rest paths)))))

(load-all-user!)

(defn save-port-file!
  [{:keys [port]}]
  (let [port-file (io/file ".nrepl-port")]
    (.deleteOnExit port-file)
    (spit port-file port)))

(defn start-nrepl-server
  []
  (let [middleware (map resolve
                        cider.nrepl/cider-middleware)
        handler (apply default-handler middleware)]
    (doto (start-server :handler handler)
          (save-port-file!))))

(defonce nrepl-server (start-nrepl-server))

(defn stop-nrepl-server
  []
  (stop-server nrepl-server))


