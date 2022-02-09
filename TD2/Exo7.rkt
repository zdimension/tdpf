(define full-reverse
  (lambda(l)
    (define aux (lambda (l)
                  (cond
                    ((null? l) l)
                    ((list? l) (append (aux (cdr l)) (list (aux (car l)))))
                    (else l)
                    )))
    (if (list? l)
        (aux l)
        (error "bad list"))))

(full-reverse '(1 (2 (3 4) 5) (6 7) (8)) )
(full-reverse '(1 (2 (3 (4 (5))))) )
(full-reverse 'symbole)