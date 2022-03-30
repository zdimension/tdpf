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

(define stream (lambda args (list->stream args)))

(define strm (stream-interval 2 10))
(define strm2 (stream-map (λ (x) (* x x)) strm))
(print (stream->list (list->stream '(1 4 6 8))))

(define s (stream 1 2 10 20 17 19 14))
(stream->list s)