(define remove1
  (lambda(obj l)
    (cond
      ((equal? (car l) obj) (cdr l))
      (else (append (list (car l)) (remove1 obj (cdr l)))))))
(remove1 1 '(0 1 2 3 0 1 2 3))

(define remove2
  (lambda(obj l)
    (cond
      ((null? l) l)
      ((equal? obj l) (list))
      ((list? l) (append (remove2 obj (car l)) (remove2 obj (cdr l))))
      (else (list l)))))
(remove2 1 '(0 1 2 3 0 1 2 3))