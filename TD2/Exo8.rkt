(define is-in?
  (lambda(obj lst)
    (cond
      ((null? lst) #f)
      ((equal? obj lst) #t)
      ((list? lst) (or (is-in? obj (car lst)) (is-in? obj (cdr lst))))
      (else #f))))
(is-in? 'y '(x (y z) w) )
(is-in? '(a b) '(x (y (a b) z) w) )
(is-in? '(a b) '(x a b y) )
(is-in? 'x '(x))
(is-in? 'x '())
(is-in? '() '())