(define full-reverse
  (lambda(l)
    (cond
      ((null? l) l)
      ((list? l) (append (full-reverse (cdr l)) (list (full-reverse (car l)))))
      (else l)
      )))

(full-reverse '(1 (2 (3 4) 5) (6 7) (8)) )
(full-reverse '(1 (2 (3 (4 (5))))) )
(full-reverse 'symbole)