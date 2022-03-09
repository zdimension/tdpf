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

(define-macro (prog1 e1 . en)
  `(begin
    (define res ,e1)
    ,@en
    res))

(define l '(a b c))
(pp (macro-expand `(prog1 (car l) (set! l (cdr l)))))
(prog1 (car l) (set! l (cdr l)))  ;; équivalent à pop
l