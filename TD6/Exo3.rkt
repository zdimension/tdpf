;; Spécificités DrScheme (plus nécessaire dans les versions récentes)
(require mzlib/defmacro)

;; Un macro-expand qui correspond à celui du cours
(define-macro (macro-expand m)
  `(syntax-object->datum (expand-once ,m)))

;; Un macro-expand "récursif"
(define-macro (macro-expand* m)
  `(syntax-object->datum (expand-to-top-form ,m)))

;; Une fonction pretty-print (avec largeur optionnelle)
(define (pp form . width)
  (pretty-print-columns (if (null? width) 30 (car width)))
  (pretty-print form))

(define-macro (define-func params . body)
  (let ((fname (car params)) (args (cdr params)))
    `(define (,fname ,@(map car args))
       ,@(map (lambda (arg)
                (if (pair? (cdr arg))
                    `(unless ,(reverse arg)
                       (error ,(apply format "incorrect type for ~a (expected ~a)" arg)))))
              args)
       ,@body)))

(macro-expand '(define-func (puissance (x) (y integer?))
                 (expt x y)))

(define-func (puissance (x) (y integer?))
  (expt x y))

(puissance 2 4)
(puissance 'a 2)
(puissance 2 'a)
