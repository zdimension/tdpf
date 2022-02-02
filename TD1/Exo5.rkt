(define dérivée
  (lambda(f)
    (lambda(x dx)
      (/ (- (f (+ x dx)) (f x)) dx))))
(define carre (lambda (n) (* n n)))
(define d-carre (dérivée carre))
(d-carre 3 0.001)

(define dérivée
  (lambda(f dx)
    (lambda(x)
      (/ (- (f (+ x dx)) (f x)) dx))))
(define d-carre (dérivée carre 0.001))
(d-carre 3)