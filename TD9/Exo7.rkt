(load "eval-cps-0.ss")

(set! evaluate (lambda (expr env k)
                 (cond
                   ((symbol? expr)
                    (k (find-binding expr env)))
                   ((pair?   expr)
                    (case (car expr)
                      ((quote)  (k (cadr expr)))
                      ((begin)  (evaluate-compound (cdr expr) env k))
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
                      (else     (evaluate-list expr
                                               env
                                               (λ (v) (funcall (car v) (cdr v) env k))))))
                   (else
                    (k expr)))))

(set! funcall (lambda func l env k)
  (cond
    ((closure? func)
        (evaluate-compound (closure-body func)
                           (extend-env (closure-args func)
                                       l
                                       (closure-env func))
                           k))
    ((kontinuation? func)
        (apply (continuation-value func) l))
    (else
        (k (apply func l)))))


(init-interpreter)
(evaluate '(list (if #t 'VRAI 'FAUX)) *global-env* print)
(evaluate '(list (if #f 'VRAI 'FAUX)) *global-env* print)

(init-interpreter)
(evaluate '(list (if #t 'VRAI)) *global-env* print)
(evaluate '(list (if #f 'VRAI)) *global-env* print)

(init-interpreter)
(evaluate '(begin
             (define ++ (macro (v) (list 'set! v (list '+ v 1))))
             (define var 10)
             (++ var)
             var)
          *global-env*
          print)