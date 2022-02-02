(define flat
  (lambda(l)
    (cond
      ((null? l) l)
      ((list? l) (append (flat (car l)) (flat (cdr l))))
      (else (list l))
      )))
(flat '(a (b (c) ((d))) e () (f)) )
(flat '(() 1 () 2 () 3) )
(flat '(((((x))))) )
(flat '(() () () ()))