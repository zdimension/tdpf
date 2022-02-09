(define swap
  (lambda(l)
    (define rev (reverse (cdr l)))
    (cons (car rev) (append (reverse (cdr rev)) (list (car l))))))
(swap '(1 2))
(swap '(1 2 3 4))
(swap '((1 2)(3 4)))
(swap '(x () y))