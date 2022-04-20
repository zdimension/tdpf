(define-macro (make-generator  . body)
  `(let ()
     (define return #f)
     (define resume #f)
     (define (yield value)
       (call/cc (lambda (k) (set! resume k) (return value))))

     ;; le résultat est une fonction qui capture return, resume et yield
     (λ ()
       (call/cc (λ (k)
                  (set! return k)
                  (if resume
                      (resume 'unused)
                      (begin
                        ,@body
                        '*END*)))))))

(define G (make-generator
           (yield 'foo)
           (yield 'bar)))
(G)
(G)
(G)
(G)

(define fib (make-generator
             (let Loop ((i 0) (j 1))
               (yield i)
               (Loop j (+ i j)))))
(let Loop ((n 0))
  (when (< n 10)
    (printf "Fib(~s)= ~s\n" n (fib))
    (Loop (+ n 1))))