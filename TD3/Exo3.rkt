(define add2 (lambda (a b) (+ a b)))

(define (add . lst) (foldl add2 0 lst))

(add 1 2)
(add 1 2 3)
(add 1 2 3 4 5)
(add 1)
(add)