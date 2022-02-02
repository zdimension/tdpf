(define fact
  (lambda(n)
  (if (<= n 0)
      1
      (* n (fact (- n 1))))))
(fact 0)
(fact 5)
(fact 50)

(define fib
  (lambda(n)
    (if (<= n 1)
        n
        (+ (fib (- n 1)) (fib (- n 2))))))
(fib 5)
(fib 25)