{:user
 {:dependencies [[com.github.vertical-blank/sql-formatter "2.0.3"]
                 [nrepl/nrepl "1.0.0"]]

  :source-paths [#=(eval (str (System/getenv "HOME") "/.clojure/dev"))]}
 :socket-repl
 {:jvm-opts ["-Dclojure.server.repl={:address,\"0.0.0.0\",:port,50505,:accept,clojure.core.server/repl}"]}}
