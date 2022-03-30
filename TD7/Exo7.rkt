(load "stream-lib.ss")

(define (stream-firsts n strm)
  (if (or (= n 0) (null? strm))
      ()
      (cons-stream (head strm) (stream-firsts (- n 1) (tail strm)))))

(define (stream-firsts-as-list n strm)
  (if (or (= n 0) (null? strm))
      ()
      (cons (head strm) (stream-firsts-as-list (- n 1) (tail strm)))))

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))

(define (list->stream lst)
  (if (null? lst)
      ()
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define stream (lambda args (list->stream args)))

(define s (stream-firsts 3 (stream  1 3 5 7 9)))       ;; 3 premiers de {1 3 5 7 9}
(stream->list s)                                       ;; s = { 1 3 5 }
;(1 3 5)
(stream->list (stream-firsts 100 (stream  1 3 5 7 9))) ;; 100 premiers de {1 3 5 7 9}
;(1 3 5 7 9)
(stream-firsts 5 (integers-from 42))                   ;; 5 premiers d'un stream infini
;(42 43 44 45 46)

(stream-firsts-as-list 3 (stream  1 3 5 7 9))   ;; 3 premiers de {1 3 5 7 9}
;(1 3 5)
(stream-firsts-as-list 100 (stream  1 3 5 7 9)) ;; 100 premiers de {1 3 5 7 9}
;(1 3 5 7 9)
(stream-firsts-as-list 5 (integers-from 42))     ;; 5 premiers d'un stream infini
;(42 43 44 45 46)