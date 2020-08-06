{:rebl
 {:plugins [[lein-localrepo "0.5.4"]]
  :dependencies [[nrepl-rebl "0.1.1"]
                 [com.cognitect/rebl "0.9.220"]]
  :jvm-opts ["-Dclojure.server.repl={:port 5555 :accept clojure.core.server/repl}"]
  :repl-options {:nrepl-middleware [nrepl-rebl.core/wrap-rebl]}}

 :default
 {:source-paths [#=(eval (str (System/getenv "HOME") "/.clojure/dev"))]
  :dependencies [[nrepl/nrepl "0.7.0"]
                 [cljfmt "0.5.1"]]
  :plugins [[cider/cider-nrepl "0.24.0"]]}

 :user
 {:plugins [[lein-binplus "0.6.6"]]}}
