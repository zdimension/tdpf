(define (make-hook where hook fct)
  (case where
    ((before) (lambda args (apply hook args) (apply fct args)))    ;; 1
    ((after)  (lambda args (hook (apply fct args))))   ;; 2
    ((around) (lambda args (apply hook fct args)))    ;; 3
    (else     (error "WHERE is incorrect"))))
  

(define my-sqrt (make-hook 'before
                           (λ (args) (printf "Call sqrt with ~a\n" args))
                           sqrt))

(my-sqrt 10)

(define my-sin (make-hook 'after
                          (λ (res . args) (abs res))
                          sin))
(sin (- (/ 3.14156 2)))
(my-sin (- (/ 3.14156 2)))

(define (fact n)
  (if (<= n 1)
      1
      (* n (fact (- n 1)))))
(set! fact (make-hook 'around
                      (λ (fct . args)
                        (printf "Calling arguments: ~a\n" args)
                        (let ((res (apply fct args)))
                          (printf "Résult: ~a\n" res)
                          res))
                      fact))
(fact 4)