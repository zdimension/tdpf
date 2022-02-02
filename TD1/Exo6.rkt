(define Pair?
  (lambda(n)
    (if (= n 0)
        #t
        (Impair? (- n 1)))))
(define Impair?
  (lambda(n)
    (if (= n 0)
        #f
        (if (= n 1)
            #t
            (Pair? (- n 1))))))
(Pair? 0)
(Impair? 1)
(Impair? 1234)