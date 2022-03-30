(define head car)
(define (tail f)
  (force (cdr f)))
(define-macro (cons-stream a b)
  `(cons ,a (delay ,b)))

(define (stream-interval low high)  ;;; return the stream {low low +1 ... high}
  (if (> low high)
      '()
      (cons-stream low (stream-interval (+ low 1) high)))) ; ⟸ remplacer cons par cons-stream

(define strm (stream-interval 2 10))

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))


(define (stream-map fct strm)
  (if (pair? strm)
      (cons-stream (fct (head strm)) (stream-map fct (tail strm)))
      ()))

(define (list->stream lst)
  (if (null? lst)
      ()
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define (stream-append s1 s2)
  (if (null? s1)
      s2
      (cons-stream (head s1) (stream-append (tail s1) s2))))

(define stm1 (stream-interval 0 5))   ;; stm1 = {0 1 2 3 4 5}
(define stm2 (stream-interval 6 9))   ;; stm2 = {6 7 8 9}
(define s (stream-append stm1 stm2))  ;; s = {0 1 2 3 4 5 6 7 8 9}
(print (stream->list s))