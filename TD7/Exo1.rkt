(load "stream-lib.ss")

(define-macro (my-delay expr)
  `(let ((val ()))
     (lambda ()
       (when (null? val)
         (set! val (list ,expr)))
       (car val))))

(define (my-force promise) (promise))

(define p (delay (begin (display "Value: ") (+ 10 20))))
(force p)
(force p)

(define p (my-delay (begin (display "Value: ") (+ 10 20))))
(my-force p)
(my-force p)