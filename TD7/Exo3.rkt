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
strm

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))

(stream->list strm)