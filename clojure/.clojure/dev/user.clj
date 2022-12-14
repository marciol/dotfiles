(ns user)

(defn foo []
  (println "bar"))

(comment
  (foo)
  (require '[esource.web.specs.document.core :as spec.document.core])
  (require '[malli.core :as m])
  (require '[malli.error :as me])
  #_
  (me/humanize
    (m/explain spec.document.core/response-unconfirmed-200
               _data)))

