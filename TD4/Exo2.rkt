(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term
              (next a)
              next
              b))))

(define (step s) (lambda (x) (+ x s)))

(define (rep1 n) (sum identity 1 (step 1) n))
(define (rep2 n) (sum (lambda (x) (* x x)) 1 (step 1) n))
; f(x) = x²-1
; F(x) = 1/3 x³ - x + C
; int 3->5 = (5^3/3-5) - (3^3/3 - 3) ~= 30.666~
(define dx 0.0001)
(define (rep3 a b) (sum (lambda (x) (* dx (- (* x x) 1))) a (step dx) b))