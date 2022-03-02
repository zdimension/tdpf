(define (append2 l1 l2)
  (cond
    ((null? l1) l2)
    ((pair? l1) (cons (car l1)
                      (append2 (cdr l1) l2)))
    (else       (error "bad list" l1))))

(define (my-append . lst) (foldr append2 (list) lst))

(define (my-append . lst)
  (cond
      ((null? lst) (list))
      ((pair? lst) (append2 (car lst) (apply my-append (cdr lst))))
      (else (error "bad list"))))

(my-append '(1 2 3) '(4 5))            ; ⇒ (1 2 3 4 5)
(my-append '(1 2 3) '(4 5) '(6 7 9))   ; ⇒ (1 2 3 4 5 6 7 9)
(my-append '(1 2 3))                   ; ⇒ (1 2 3)
(my-append)                            ; ⇒ ()