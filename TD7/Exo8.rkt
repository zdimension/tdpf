(load "stream-lib.ss")

(define (list->stream lst)
  (if (null? lst)
      ()
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define stream (lambda args (list->stream args)))

(define (stream-merge s1 s2)
  (cond
    ((null? s1) s2)
    ((null? s2) s1)
    (else
     (let ((n1 (head s1)) (n2 (head s2)))
       (if (< n1 n2)
           (cons-stream n1 (stream-merge (tail s1) s2))
           (cons-stream n2 (stream-merge s1 (tail s2))))))))

(define (stream->list strm)
  (if (pair? strm)
      (cons (head strm) (stream->list (tail strm)))
      ()))

(define s (stream-merge (stream 1 3 8 9 10)
                        (stream 2 5 8 9)))      ;; ⟹ {1 2 3 5 8 8 9 9 10}
(stream->list s)
;(1 2 3 5 8 8 9 9 10)
;; Un merge de 3 steam
(stream->list (stream-merge (stream 1 3 18 20 100)
                            (stream-merge (stream -7 -4 3 9 11 20 110)
                                          (stream 5 8 200 210))))
;(-7 -4 1 3 3 5 8 9 11 18 20 20 100 110 200 210)