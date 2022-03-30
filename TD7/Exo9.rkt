(load "stream-lib.ss")

(define (list->stream lst)
  (if (null? lst)
      ()
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define stream (lambda args (list->stream args)))

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))

(define (stream-firsts n strm)
  (if (or (= n 0) (null? strm))
      ()
      (cons-stream (head strm) (stream-firsts (- n 1) (tail strm)))))


(define (stream-map func . strms)
  (if (ormap null? strms)
      ()
      (cons-stream (apply func (map head strms))
                   (apply stream-map func (map tail strms)))))

;; Appel avec des flots de même longueur
(define s (stream-map cons (stream 'a 'b 'c) (stream 1 2 3)))
(head s)
;(a . 1)
(stream->list s)
;((a . 1) (b . 2) (c . 3))

;; Appel avec des flots de longueurs différentes
(define t (stream-map + (stream 10 20 30 40) 
                      (stream 1 2)))
(stream->list t) 
;(11 22)

;; avec des flots infinis
(define s (stream-map + (integers-from 0) (integers-from 0)))
(stream->list (stream-firsts 10 s))   ;; => le flot infini des entiers pairs.
;(0 2 4 6 8 10 12 14 16 18)