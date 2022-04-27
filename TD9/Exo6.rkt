(require racket/trace)

(define (kreverse lst k)
  (cond
    ((null? lst) (k lst))
    ((pair? lst) (kreverse (cdr lst) (lambda (res) (k (append res (list (car lst)))))))
    (else (error "bad list" lst))))

(kreverse '(1 2 3) println)
(kreverse '(a b c (d e f) (g h)) println)
(kreverse '() println)

(define (kfact n k)
  (if (<= n 1)
      (k 1)
      (kfact (- n 1) (lambda (res) (k (* n res))))))

(kfact 10 println)
(kfact 0 println)
(kfact 20 println)

(define (kfib n k)
  (if (<= n 1)
      (k n)
      (kfib (- n 1) (lambda (res)
                      (kfib (- n 2) (lambda (res2) (k (+ res res2))))))))

(kfib 0 println)
(kfib 1 println)
(kfib 25 println)
(kfib 10 println)

(define (kappend l1 l2 k)
  (cond
    ((null? l1) (k l2))
    ((pair? l1) (kappend (cdr l1) l2 (lambda (res) (k (cons (car l1) res)))))
    (else       (error "Append: bad list"))))

(kappend '(1 2 3) '(4 5 6) println)
(kappend '(1 (2 3)) '(((4) 5) 6) println)