(define-macro (lambda* . overloads)
  `(lambda args
    (let ((len (length args)))
      (case len
        ,@(map (lambda (o) `((,(length (car o))) (apply (lambda ,(car o) ,@(cddr o)) args))) overloads)
        (else (error (format "pas de corps pour une liste de longueur ~a" len)))))))

(define foo
  (lambda*
   (()        => 'zero)
   ((x)       => (list 'one x))
   ((x y)     => (list 'two x y))
   ((x y z w) => (display "4e clause") (list 'four x y z w))))

(print (foo))
(print (foo 1))
(print ( foo 1 2))
(print (foo 1 2 3 4))