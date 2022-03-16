(define-macro (named-let name bindings body)
  `(letrec ((,name (lambda ,(map car bindings) ,body)))
     (,name ,@(map cadr bindings))))

(define-macro (let head . tail)
  (if (pair? head)
      `((lambda ,(map car head) ,@tail) ,@(map cadr head))
      `(letrec ((,head (lambda ,(map car (car tail)) ,(cadr tail))))
         (,head ,@(map cadr (car tail))))))

(let Loop ((i 0))
  (when (< i 10)
    (display i)
    (Loop (+ i 1))))

(let ((i 5)) (display i))