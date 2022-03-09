(define-macro (debug expr)
  `(printf "~s => ~s\n" ',expr ,expr))

(debug (+ 1 2 3))
(debug (cons "Hello" '("world" "!")))
(define a 10)
(debug a)