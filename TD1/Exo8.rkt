(define sigma
  (lambda(f)
    (define res (lambda (n)
      (if (< n 0)
          0
          (+ (f n) (res (- n 1))))))
    res))
(define somme-carrés (sigma (lambda(n) (* n n))))
(somme-carrés 10)
(somme-carrés 100)