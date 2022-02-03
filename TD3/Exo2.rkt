(define (show . lst)
  (for-each (λ (x)
              (display x)
              (display " "))
            lst)
  (newline))

(define depl (lambda (a b) (show "deplacer un disque de" a "vers" b)))

(define aux
  (lambda (n from to tmp)
    (if (= n 1)
        (depl from to)
        (begin
          (aux (- n 1) from tmp to)
          (depl from to)
          (aux (- n 1) tmp to from)))))
  
(define hanoi
  (lambda (n)
    (aux n 'a 'b 'c)))

(hanoi 3)