;;;
;;; Les fonctions définies dans le cours 08
;;;
;;;           Author: Erick Gallesio [eg@unice.fr]
;;;    Creation date: 29-Mar-2019 18:08
;;; Last file update:  1-Apr-2019 16:02 (eg)


;;; ======================================================================
;;;                               Backtrackiing
;;; ======================================================================

;;
;; FAIL
;;
(define fail #f)

(define (init-fail)
  (set! fail (λ () (error "exhausted!!"))))

(init-fail) ;; to force initialization of the fail function

;;
;; ASSERT
;;
(define (assert expr)
  (unless expr
    (fail)))

;;
;; TO
;;
(define (to a b)
  (let ((save fail))
    (call/cc
     (λ (return)
       (let Loop ((n a))
         (assert (<= n b))
         (set! fail (λ () (set! fail save) (Loop (+ n 1))))
         (return n))))))


;;
;; THREE-DICES
;;
(define (three-dices sum)
  (let ((d1 (to 1 6))
        (d2 (to 1 6))
        (d3 (to 1 6)))
    (assert (= (+ d1 d2 d3) sum))
    (list d1 d2 d3)))

;;; ======================================================================
;;;                               Coroutines
;;; ======================================================================
(define-macro (coroutine . body)
  `(let ()
     (define state (λ () ,@body))
     (define (resume c)
       (call/cc (λ (resume-point)
          (set! state resume-point)
          (c))))
     ;; Construire le résultat
     (λ () (state))))


(define A (coroutine
           (print "début de A")
           (resume B)
           (print "milieu de A")
           (resume B)
           (print "fin de A")
           17))


(define B (coroutine
           (print "début de B")
           (resume A)
           (print "milieu de B")
           (resume A)
           (print "fin de B")))
