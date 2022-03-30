;;;; A small stream library
;;;;
;;;;           Author: Erick Gallesio [eg@unice.fr]
;;;;    Creation date: 25-Mar-2019 12:28
;;;; Last file update: 25-Mar-2019 22:57 (eg)


;; ======================================================================
;;              Streams primitives
;; ======================================================================
(define-macro (cons-stream a b) `(cons ,a (delay ,b)))
(define head car)
(define (tail f) (force (cdr f)))
(define stream-null? null?)
(define (stream? stm) (and (pair? stm) (promise? (cdr stm))))

;; ======================================================================
;;             Streams functions
;; ======================================================================
(define (stream-interval low high)  ;;; return the stream {low low +1 ... high}
  (if (> low high)
      '()
      (cons-stream low (stream-interval (+ low 1) high))))

(define (integers-from n)
  (cons-stream n (integers-from (+ n 1))))

(define (stream-filter fct stm)
  ;; (printf "Stream filter on ~S\n" stm)
  (cond
    ((stream-null? stm) '())
    ((pair? stm)        (if (fct (head stm))
                            (cons-stream (head stm)
                                         (stream-filter fct (tail stm)))
                            (stream-filter fct (tail stm))))
    (else (error "bad stream " stm))))


(define (stream-ref stm k)
  (cond
    ((null? stm) (error "index too large"))
    ((pair? stm) (if (zero? k)
                     (head stm)
                     (stream-ref (tail stm) (- k 1))))
    (else        (error "bad stream"))))


(define (stream-for-each proc stm)
  (unless (null? stm)
    (proc (head stm))
    (stream-for-each proc (tail stm))))


(define (stream-add stm1 stm2)
  (cond
    ((stream-null? stm1) '())
    ((stream-null? stm2) '())
    (else (cons-stream (+ (head stm1) (head stm2))
                       (stream-add (tail stm1)
                                   (tail stm2))))))

(define (stream-mult stm1 stm2)
  (cond
    ((stream-null? stm1) '())
    ((stream-null? stm2) '())
    (else (cons-stream (* (head stm1) (head stm2))
                       (stream-mult (tail stm1)
                                    (tail stm2))))))
