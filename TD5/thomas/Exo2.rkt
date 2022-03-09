(define (create-accumulator n)
  (let ((val n))
    (lambda (x)
      (set! val (if (equal? x 'init) n (+ x val)))
      val)))

(define a (create-accumulator 100))

(a 10)
(a 20)
(a 'init)
(a 10)
(a 20)