(define-macro (for-all var in lst . body)
  `(for-each (lambda (,var) ,@body) ,lst))

(for-all x in '(10 20 -17)
  (printf "carré de ~s = ~s\n" x (* x x)))

(for-all item in '((x . 10) (y . 20) (z . 30))
  (printf "item = ~s\n" item)
  (print (car item))
  (print (cdr item)))