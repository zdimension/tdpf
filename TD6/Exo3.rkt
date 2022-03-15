(define (simple-trace-function func name)
  (lambda args
    (printf "Calling ~A\n" (cons name args))
    (let ((res (apply func args)))
      (printf "Result: ~A\n" res)
      res)))

(define fib (λ (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))
(set! fib (simple-trace-function fib 'fib))
(fib 3)

(define (trace-function func name)
  (let ((i 0))
    (lambda args
      (let ((s (make-string i #\.)))
        (printf "~A Calling ~A\n" s (cons name args))
        (set! i (+ i 3))
        (let ((res (apply func args)))
          (set! i (- i 3))
          (printf "~A Result: ~A\n" s res)
          res)))))

(define fib (λ (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))
(set! fib (trace-function fib 'fib))
(fib 3)

(define-macro (trace func)
  `(set! ,func (trace-function ,func ',func)))

(define (fact n)
  (if (<= n 1)
      1
      (* n (fact (- n 1)))))
(trace fact)
(fact 4)

; avec untrace
(define $trace$ '())
(define (trace-function func name)
  (let ((i 0))
    (set! $trace$ (cons (cons name func) $trace$))
    (lambda args
      (let ((s (make-string i #\.)))
        (printf "~A Calling ~A\n" s (cons name args))
        (set! i (+ i 3))
        (let ((res (apply func args)))
          (set! i (- i 3))
          (printf "~A Result: ~A\n" s res)
          res)))))

(define (untrace-function name)
  (let ((backup (assoc name $trace$)))
    (if backup (cdr backup) (error "function was not traced"))))

(define-macro (untrace func)
  `(set! ,func (untrace-function ',func)))

(define (fact n)
  (if (<= n 1)
      1
      (* n (fact (- n 1)))))
(trace fact)
(fact 4)
(untrace fact)
(fact 4)