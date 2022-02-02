(define rotation-gauche
  (lambda(l)
    (append (cdr l) (list (car l)))))
(rotation-gauche '(a b c d))
(define rotation-droite
  (lambda(l)
    (define rev (reverse l))
    (append (list (car rev)) (reverse (cdr rev)))))
(rotation-droite '(a b c d))