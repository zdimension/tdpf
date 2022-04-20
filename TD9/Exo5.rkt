(load "Exo4.rkt")

(let ((eval-old evaluate) (funcall-old funcall))
  (set! evaluate (lambda (expr env)
                   (if (and (pair? expr) (eq? 'dlambda (car expr)))
                       (make-closure (cadr expr) (cddr expr) #f)
                       (eval-old expr env))))

  (set! funcall (lambda (func args env)
                  (if (closure? func)
                      (evaluate-compound (closure-body func)
                         (extend-env (closure-args func)
                                     args
                                     (or (closure-env func) env)))
                      (funcall-old func args env)))))