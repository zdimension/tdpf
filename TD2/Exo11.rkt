(define remove-all
  (lambda(obj l)
    (if (null? l)
        (list)
        (append (if (equal? obj (car l))
                    (list)
                    (list (car l)))
                (remove-all obj (cdr l))))))

(define aux
  (lambda(gauche droite)
    (if (null? droite)
        gauche
        (aux (append gauche (list (car droite))) (remove-all (car droite) (cdr droite))))))

(define remove-duplicate
  (lambda(l)
    (aux '() l)))

(remove-duplicate '(x (x y) x z (x) x) )
(remove-duplicate '(a (a b) b (a b) a (a b) b) )
(remove-duplicate '(a (a (a (a)))) )