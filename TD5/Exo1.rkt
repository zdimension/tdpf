(define (create-accumulator k)
  (let ((accu k))
    (lambda (x)
      (set! accu (+ x accu))
      accu)))

(define a (create-accumulator 100)) ; 100 = valeur initiale acc.
(define b (create-accumulator 0))    ; 0 = valeur initiale acc.
(a 10)
(a 20)
(a 30)
(b 1)
(b 1)