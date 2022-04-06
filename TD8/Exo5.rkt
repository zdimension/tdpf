(load "call-cc-lib.ss")

(define-macro (coroutine . body)
  `(let ()
     (define initial (λ (unused)
                       (let ((res (begin ,@body)))
                         (set! state initial)
                         res)))
     (define state initial)
     (define (resume c)
       (call/cc (λ (resume-point)
          (set! state resume-point)
          (c))))
     ;; Construire le résultat
     (λ ()                            ;; 1
       (state 'useless))))            ;; 2

(define A (coroutine
           (display "State 1\n")
           (resume A)              ;; et pourquoi pas soi-même?
           (display "State 2\n")
           (resume A)
           (display "State 3\n")
           '**A**))                 ;; **A**: le résultat de la coroutine

(A)
(A)
(A)

(define A (coroutine
           (display "A.1\n")
           (resume B)
           (display "A.2\n")
           '**A**))

(define B (coroutine
           (display "B.1\n")
           (resume A)
           (display "B.2\n")
           '**B**))

(A)
(A)