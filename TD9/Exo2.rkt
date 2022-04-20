(load "Exo1.rkt")

(let ((interp-orig interp)
      (*top* #f))

  (set-binding! 'exit (lambda() (*top*)) *global-env* #f)

  (set! interp
        (lambda()
          (call/cc (lambda(k)
                     (set! *top* k)
                     (interp-orig)
                     )))))