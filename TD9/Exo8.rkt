(load "eval-cps-0.ss")

(set! evaluate (lambda (expr env k)
                 (cond
                   ((symbol? expr)
                    (k (find-binding expr env)))
                   ((pair?   expr)
                    (case (car expr)
                      ((quote)  (k (cadr expr)))
                      ((begin)  (evaluate-compound (cdr expr) env k))
                      ((with-return) (k (call/cc (lambda (ret)
                                                   (evaluate-compound (cdr expr)
                                                                      (extend-env '(return) (list (lambda (x) (ret x))) env) ret)))))
                      ((set!)   (evaluate (caddr expr)
                                          env
                                          (λ (v)
                                            (k (set-binding! (cadr expr) v env #t)))))
                      ((define) (evaluate (caddr expr)
                                          env
                                          (λ (v)
                                            (k (set-binding! (cadr expr) v env #f)))))
                      ((if)     (evaluate (cadr expr)
                                          env
                                          (λ (v)
                                            (if v
                                                (evaluate (caddr expr) env k)
                                                (if (not (null? (cdddr expr)))
                                                    (evaluate (cadddr expr) env k)
                                                    (k (void)))))))
                      ((call/cc) ;; Simulate call: (v (make-continuation k))
                       (evaluate (cadr expr)
                                 env
                                 (λ (v) (funcall v
                                                 (list (make-continuation k))
                                                 env
                                                 k))))
                      ((lambda) (k (make-closure (cadr expr) (cddr expr) env)))
                      ((macro) (k (make-macro (cadr expr) (cddr expr) env)))
                      (else
                       (evaluate (car expr) env
                                 (lambda (res)
                                   (if (macro? res) (macro-expand res (cdr expr) (lambda (mres) (evaluate mres env k)))
                                       (evaluate-list (cdr expr) env (lambda (res2)
                                                                       (funcall res res2 env k)))))))))
                   (else
                    (k expr)))))

(init-interpreter)
(evaluate '(with-return
               (print "Hello")
             (print "World")
             "END")
          *global-env*
          print)

(init-interpreter)
(evaluate '(with-return
               (print "Hello")
             (return 'on-sort)
             (print "World")
             "END")
          *global-env*
          (lambda (k) (print "bonjour")))