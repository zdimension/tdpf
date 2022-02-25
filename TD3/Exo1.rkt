(define remove-if
  (lambda(pred lst)
    (cond
      ((null? lst) lst)
      ((pair? lst)
       (if (pred (car lst)) (remove-if pred (cdr lst))
           (append (list (car lst)) (remove-if pred (cdr lst)))))
      (else (error "bad list")))))

(remove-if number? '(a 1 (1) 2 (x y) ()) )
(remove-if (λ (x)(< x 5)) '(6 2 9 3 7 1) )
(remove-if null? '(a () 1 () (())))

(define count-if
  (lambda(pred lst)
    (cond
      ((null? lst) 0)
      ((pair? lst)
       (if (pred (car lst)) (+ 1 (count-if pred (cdr lst)))
           (count-if pred (cdr lst))))
      (else (error "bad list")))))

(count-if symbol? '(a (a) () c (x y) b) )
(count-if (λ (x)(> x 0)) '(-1 2 0 3 -5 -10 7) )

(define find-if
  (lambda(pred lst)
    (cond
      ((null? lst) #f)
      ((pair? lst)
       (if (pred (car lst)) (car lst)
           (find-if pred (cdr lst))))
      (else (error "bad list")))))

(find-if list? '(a 1 (x y) () (a b)) )
(find-if (λ (x)(> x 10)) '(2 5 12 1 15) )

(define remove-if-not
  (lambda(pred lst)
    (remove-if (compose not pred) lst)))

(define remove-if-not
  (lambda(pred lst)
    (remove-if (lambda (x) (not (pred x))) lst)))

(remove-if-not (λ (x)(< x 5))
               '(6 2 9 3 7 1) )
(remove-if-not null? '(a () 1 () (())) )