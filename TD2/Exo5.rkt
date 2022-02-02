(define List-ref
  (lambda(lst n)
    (if (= n 0)
        (car lst)
        (List-ref (cdr lst) (- n 1)))))
(List-ref '(a b c) 0)  ; a
(List-ref '(a b c) 2)  ; c
;(List-ref '(a b c) 5)  ; erreur

(define Member
  (lambda(val lst)
    (cond
      ((null? lst) #f)
      ((equal? (car lst) val) lst)
      (else (Member val (cdr lst))))))
(Member 3 '(1 2 3 4 5))   ; (3 4 5)
(Member 1 '(1 2 3 4 5))   ; (1 2 3 4 5)
(Member 6 '(1 2 3 4 5))   ; #f
(Member 2 '(1 (2 3 4) 5)) ; #f