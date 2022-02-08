(define (memo f)
  (let ((a-list '()))    ;; la liste des résultats déjà connus
    (λ (x)
      (let ((previous (assoc x a-list)))
        (if previous
            (cdr previous)
            (let ((res (f x)))
              (set! a-list (append a-list (list (cons x res))))
              ;; On peut maintenant renvoyerres à l'utilisateur
              res))))))

(define (fib n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
(define mfib (memo fib))
(mfib 34) ; réponse longue
(mfib 34) ; réponse immediate
