(define (kreverse lst k)
  (if (null? lst) (k lst)
      (kreverse (cdr lst) (lambda (l) (k (append l (list (car lst))))))
      )
  )

(define (kfact n k)
  (if (eq? 0 n) (k 1)
      (kfact (- n 1) (lambda (res) (k (* res n))))
      )
  )

(define (kfib n k)
  (cond
    ((eq? 0 n) (k 0))
    ((eq? 1 n) (k 1))
    (else
     (kfib (- n 1) (lambda (res) (kfib (- n 2) (lambda (res2) (k (+ res res2))))))
      )
  )
  )

(define (kappend l1 l2 k)
  (cond
    ((null? l1) (k l2))
    ((null? l2) (k l1))
    (else
     (kappend (cdr l1) l2 (lambda (l) (k (cons (car l1) l))))
     )
    )
  )
