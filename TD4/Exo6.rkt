(define (curry fct param)
  (lambda params (apply fct param params)))

(define Add1 (curry + 1))
(Add1 10)

(define double (curry * 2))
(double 10)

(define doubles (curry map double)) ;; double sur chaque élement d'une liste
(doubles '(1 2 3 4 5 6))

(define associer (curry map cons))  ;; association variable valeur ...
(associer '(a b c) '(1 2 3))