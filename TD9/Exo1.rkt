(load "eval.ss")

(let ((init-orig init-interpreter) (*top* #f))
  (set! init-interpreter
        (lambda()
          (init-orig)
          (call/cc (lambda(k) (set! *top* k)))))

  (set! ms-error (lambda args
                   (printf "*** ERROR in Mini-Scheme: ~a\n"
                           (string-join (map (lambda (x) (format "~a" x)) args) " "))
                   (*top* 'unused)))

  (set-binding! 'error ms-error *global-env* #f))