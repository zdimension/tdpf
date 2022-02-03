; (define (reduce f lst base)
;   (foldr f base lst))

(define (reduce f lst base)
  (if (null? lst) base
      (f (car lst) (reduce f (cdr lst) base))))

(reduce * '(1 2 3 4 5) 1)
(reduce + '(1 2 3 4 5) 0)
(reduce (λ (item res) (append res (list item)))
        '(1 2 3 4 5)
        '())

(define (Min lst)
  (reduce (lambda (a b) (if (< a b) a b)) lst (car lst)))
(Min '(2 7 1 8 4))

(define (Max lst)
  (reduce (lambda (a b) (if (> a b) a b)) lst (car lst)))
(Max '(2 7 1 8 4))

(define (Length lst)
  (reduce (lambda (a b) (+ 1 b)) lst 0))
(Length '(2 7 1 8 4))

(define (simple-map fct lst)
  (reduce (lambda (a b) (append (list (fct a)) b)) lst (list)))
(simple-map (lambda (x) (* x x)) '(1 2 3 4 5))

(define (Filter pred? lst)
  (reduce (lambda (a b) (append (if (pred? a) (list a) (list)) b)) lst (list)))
(Filter (lambda (x) (> x 5)) '(3 6 8 4 10 12))

(define (every? pred? L)
  (reduce (lambda (a b) (and (pred? a) b)) L #t))
(every? (lambda (x) (> x 5)) '(6 19 7 8))
(every? (lambda (x) (> x 5)) '(6 19 3 7 8))

(define (any? pred? L)
  (reduce (lambda (a b) (or (pred? a) b)) L #f))
(any? (lambda (x) (> x 5)) '(1 4 3 6 2))
(any? (lambda (x) (> x 5)) '(1 2 3 4))