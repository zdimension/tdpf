(load "Exo3.rkt")

(let ((funcall-old funcall))
  (set! funcall (lambda (func args env)
                  (if (integer? func)
                      (let ((lst (car args)))
                        (list-ref lst (if (< func 0) (+ (length lst) func) func)))
                      (funcall-old func args env)))))