(define (simple-map fct lst)
  (cond
    ((null? lst) (list))
    ((list? lst) (append (list (fct (car lst))) (simple-map fct (cdr lst))))
    (else (error "bad list" lst))))

(simple-map (lambda (x) (* x x)) '(1 2 3 4 5))

(define (gen-map fct . lsts)
  (cond
    ((null? (car lsts)) (list))
    (else (append (list (apply fct (map car lsts))) (apply gen-map fct (map cdr lsts))))))

(gen-map + '(1 2 3 4) '(10 100 1000 10000))