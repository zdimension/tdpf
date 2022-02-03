(define (kons a b)
   (λ (f)
     (f a b)))

(define (kar pair) (pair (lambda (a d) a)))
(define (kdr pair) (pair (lambda (a d) d)))

(define p (kons 2 3))
(kar p)
(kdr p)