(define add2 (lambda (a b) (+ a b)))

(define (add . lst) (foldl add2 0 lst))

(define (add . lst)
  (cond
      ((null? lst) 0)
      ((pair? lst) (add2 (car lst) (apply add (cdr lst))))
      (else (error "bad list"))))

(add 1 2)
(add 1 2 3)
(add 1 2 3 4 5)
(add 1)
(add)