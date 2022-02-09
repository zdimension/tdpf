(define is-in?
  (lambda(obj lst)
    (and (pair? lst)
         (or (or (is-in? obj (car lst)) (is-in? obj (cdr lst)))
             (or (equal? obj (car lst)) (equal? obj (cdr lst)))))))

(is-in? 'y '(x (y z) w) )
(is-in? '(a b) '(x (y (a b) z) w) )
(is-in? '(a b) '(x a b y) )
(is-in? '(a b) '(a b))
(is-in? 'x '(x))
(is-in? 'x '())
(is-in? '() '())