(in-ns 'user)

;;; CLJS REPL
(require 'rebel-readline.cljs.repl
         'figwheel.main.api)
(defn cljs-repl
  []
  (let [repl-env (figwheel.main.api/repl-env "dev")]
    (rebel-readline.cljs.repl/repl repl-env)))

;;; Start nREPL server
(require '[cider.nrepl :as cider]
         '[nrepl.server :as nrepl]
         '[cider.piggieback :as pback])
(defonce server
  #_(nrepl/start-server
    :port 3575
    :handler (nrepl/default-handler #'pback/wrap-cljs-repl))
  (nrepl/start-server
    :port 3575
    :bind "0.0.0.0"
    :handler (nrepl/default-handler #'pback/wrap-cljs-repl)
    ;:handler cider/cider-nrepl-handler
    ))
;; Spit port number to the file (for Vim+fireplace)
(let [port (:port server)]
  (spit ".nrepl-port" port)
  (println "nREPL server is running on port" port))

;;; Start figwheel server
(figwheel.main.api/start {:mode :serve} "dev")

;;; Start rebel-readline (a REPL by bhauman)
(require 'rebel-readline.main)
(rebel-readline.main/-main)   ;; this will block till exit from REPL

;;; Remove the port file.
(require 'clojure.java.io)
(clojure.java.io/delete-file ".nrepl-port")

;;; We need to exit explicitly because nREPL server is running
;;; on a different thread.
;;; `(shutdown-agents)` will do too.
(println "Bye!")
(System/exit 0)
