(load "stream-lib.ss")

(define-macro (my-delay expr)
  `(let ((val ()))
     (list 'promise (lambda ()
                      (when (null? val)
                        (set! val (list ,expr)))
                      (car val)))))

(define (my-force promise) ((cadr promise)))

(define (my-promise? promise)
  (and (pair? promise) (eq? 'promise (car promise))))

(define p (delay (begin (display "Value: ") (+ 10 20))))
(force p)
(force p)

(define p (my-delay (begin (display "Value: ") (+ 10 20))))
(my-force p)
(my-force p)