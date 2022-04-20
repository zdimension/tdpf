(define-macro (make-generator  . body)
    `(let ()
       (define return #f)
       (define resume #f)
       (define (yield value)
         (call/cc (lambda (k) (set! resume k) (return value))))

       ;; le résultat est une fonction qui capture return, resume et yield
       (λ ()
         (call/cc (λ (k)
                    (if resume
                     (resume)
                     (begin
                       (set! return k)
                       ,@body
                       '*END*)))))))

(define G (make-generator
               (yield 'foo)
               (yield 'bar)))

(G)
(G)
(G)
(G)