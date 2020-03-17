; {:user {:plugins [[lein-localrepo "0.5.4"]]
;         :dependencies [[nrepl-rebl "0.1.1"]
;                        [com.cognitect/rebl "0.9.220"]]
;         :jvm-opts ["-Dclojure.server.repl={:port 5555 :accept clojure.core.server/repl}"]
;         :repl-options {:nrepl-middleware [nrepl-rebl.core/wrap-rebl]}

