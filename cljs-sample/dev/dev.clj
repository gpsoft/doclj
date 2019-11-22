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
(defn- nrepl-handler []
  (require 'cider.nrepl)
  (ns-resolve 'cider.nrepl 'cider-nrepl-handler))
(defonce server
  (nrepl/start-server
    :port 3575
    :bind "0.0.0.0"
    ;;; Not sure on `:handler` option
    ;;; fireplace-K fails on cljs with pback version
    ;;; cider-nrepl version looks okay
    ;;; figwheel-main version might be better?
    :handler
    ;(nrepl/default-handler #'pback/wrap-cljs-repl) ;; pback version
    cider/cider-nrepl-handler ;; cider-nrepl version
    ;(nrepl-handler) ;; figwheel-main version
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
