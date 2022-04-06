(load "call-cc-lib.ss")

(define-macro (on-exit expr-sortie . exprs)
  `(let ((result (call/cc (lambda (break) ,@exprs))))
     ,expr-sortie
     result))

(on-exit (displayln "Fermer le fichier ouvert...")
         (displayln "Ouvrir un fichier")
         (displayln "Travailler avec le fichier")
         ;; Pas de break, le résultat est la dernière expression (17 ici)
         17)


(on-exit (displayln "Fermer le fichier ouvert...")
         (displayln "Ouvrir un fichier")
         (displayln "Travailler avec le fichier 1")
         (when (> 1 0)
           (displayln "Ooops problème. On sort")
           (break 'oops))
         (displayln "Travailler avec le fichier 2")     ;; jamais exécuté
         17)

(define (foo n)
  (on-exit (displayln "Exit external")
           (displayln "Start external")
           (on-exit (begin (displayln "Exit internal")
                           (if (< n 0) (break 'negative)))
                    (displayln "Start internal")
                    (break 'internal)
                    (displayln "Will never be printed"))
           (printf "Will be printed because ~s ≥ 0\n" n)
           'normal-exit))

(foo 10)

(foo -1)