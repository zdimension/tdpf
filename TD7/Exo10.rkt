(load "stream-lib.ss")

(define fib-stream
  (letrec ((aux (lambda (a b) (cons-stream b (aux b (+ a b))))))
    (cons-stream 0 (aux 0 1))))

(define (stream-firsts n strm)
  (if (or (= n 0) (null? strm))
      ()
      (cons-stream (head strm) (stream-firsts (- n 1) (tail strm)))))

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))


(stream-ref fib-stream 100)        ;; la valeur de fib(100)
;354224848179261915075
(stream->list (stream-firsts 10 fib-stream))     ;; les 10 premiers nombres de Fibonacci
;(0 1 1 2 3 5 8 13 21 34)