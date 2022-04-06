(load "call-cc-lib.ss")

(define *top* #f)                    ; valeur non importante ici
(call/cc (λ (k) (set! *top* k)))

(define *user-code* #f)
(define (breakpoint . args)
  (call/cc (lambda (k)
             (set! *user-code* k)
             (display "*** Breakpoint: ")
             (for-each display args)
             (display "\n    Going back to toplevel\n")
             (*top* 'unused))))
(define (continue)
  (if (equal? #f *user-code*)
      (error "you cannot continue anymore!")
      (let ((back *user-code*))
        (set! *user-code* #f)
        (back 'unused))))

(define (test n)
  (let Loop ((i n)
             (sum 0))
    (if (> i 0)
        (begin
          (breakpoint "i = " i " sum = " sum)
          (Loop (- i 1) (+ sum i)))
        (printf "⟹ sum is ~s\n" sum))))

(test 3)
;** Breakpoint: i = 3 sum = 0
;    Going back to toplevel
(continue)
;*** Breakpoint: i = 2 sum = 3
;    Going back to toplevel
(printf "Hello\n")
;Hello
(continue)
;*** Breakpoint: i = 1 sum = 5
;    Going back to toplevel
(continue)
;⟹ sum is 6
(continue)
;ERROR: you cannot continue anymore!