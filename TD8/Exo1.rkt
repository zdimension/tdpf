(load "call-cc-lib.ss")

(define-macro (try handler . body)          ;; Non hygienic macro
  `(let ((old throw))
     (call/cc
      (λ (k)
        ;; define a new throw function
        (set! throw (λ args
                      (set! throw old)
                      (k (apply ,handler args))))

        ;; execute body with the given handler
        (let ((result (begin ,@body)))
          (set! throw old)
          result)))))

(define (throw . args) (error "No handler installed !!!"))

(define (foo n)
  (try
   ;; ==== handler
   (λ (val)
     (case val
       ((not-integer) (printf "integer expected\n"))
       ((is-negative) (printf "positive integer expected\n"))
       (else          (printf "received unknown exception: ~s\n" val))))

   ;; ==== body
   (unless (integer? n) (throw 'not-integer))
   (printf "Result is: ~s\n" (compute-value n))))

(define (compute-value v)
  (cond
    ((zero? v)     (throw 'zero))
    ((negative? v) (throw 'is-negative))
    (else          (sqrt v))))

(foo 4)
(foo "bad")
(foo -4)
(foo 0)