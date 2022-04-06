(load "call-cc-lib.ss")

(define (three-dices sum)
  (let ((d1 (to 1 6))
        (d2 (to 1 6))
        (d3 (to 1 6)))
    (assert (= (+ d1 d2 d3) sum))
    (list d1 d2 d3)))

(define (print-all-solutions n)
  (call/cc
   (lambda (k)
     (set! fail k)
     (displayln (three-dices n))
     (fail))))
(print-all-solutions 5)

(define (all-solutions n)
  (let ((res '()))
    (call/cc
     (lambda (k)
       (set! fail k)
       (set! res (cons (three-dices n) res))
       (fail)))
    res))

(all-solutions 5)
(length (all-solutions 10))