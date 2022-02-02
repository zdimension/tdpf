(define somme-carrés
  (lambda(n)
    (if (< n 0)
        0
        (+ (* n n) (somme-carrés (- n 1))))))
(somme-carrés 2)
(somme-carrés 3)
(somme-carrés 100)

(define somme-cubes
  (lambda(n)
    (if (< n 0)
        0
        (+ (* n n n) (somme-cubes (- n 1))))))
(somme-cubes 2)
(somme-cubes 3)
(somme-cubes 100)

(define sigma
  (lambda(f n)
    (if (< n 0)
        0
        (+ (f n) (sigma f (- n 1))))))
(define somme-carrés (lambda(n) (sigma (lambda(n) (* n n)) n)))
(define somme-cubes (lambda(n) (sigma (lambda(n) (* n n n)) n)))
(somme-carrés 2)
(somme-carrés 3)
(somme-carrés 100)
(somme-cubes 2)
(somme-cubes 3)
(somme-cubes 100)