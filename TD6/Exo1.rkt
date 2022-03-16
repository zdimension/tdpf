(define (fib n)
  (if (<= n 2)
      1
      (+ (fib (- n 1)) (fib (- n 2)))))

(define-macro (time expr)
  `(let ((start (current-milliseconds)) (res ,expr))
     (printf "Elapsed time: ~ams\n" (- (current-milliseconds) start))
     res))

(time (fib 34))
(time (fib 35))