(load "Exo1.rkt")

(let ((interp-orig interp) (eval-old evaluate) (*top* #f))
  (set-binding! 'exit (lambda() (*top* 'unused)) *global-env* #f)

  (set! interp
        (lambda()
          (call/cc (lambda(k)
                     (set! *top* k)
                     (interp-orig)))))

  (set! evaluate (lambda (expr env)
                   (if (and (pair? expr) (eq? 'λ (car expr)))
                       (eval-old (cons 'lambda (cdr expr)) env)
                       (eval-old expr env)))))