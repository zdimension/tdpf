(define entiers
  (lambda(n)
    (cond
      ((integer? n) 1)
      ((list? n)
       (if (null? n)
           0
           (+ (entiers (car n)) (entiers (cdr n)))))
      (else 0))))
(entiers '(1 (2 (34) 5) 6 () (78)) )
(entiers '((((1 a b))) (((x 2)))) )
(entiers '12)
(entiers '())