(define (create-accumulator k)
  (let ((accu k))
    (lambda (x)
      (set! accu
            (if (equal? x 'init)
                k
                (+ x accu)))
      accu)))

(define a (create-accumulator 100))

(a 10)
(a 20)
(a 'init)
(a 10)
(a 20)