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

(define-macro (bind params values . exprs)
  `(begin ,@(map (lambda (e) `(apply (lambda ,params ,e) ,values)) exprs)))

(macro-expand '((bind (x y) (get-mouse-coords)
                      (printf "mouse position: [~s, ~s]\n" x y))))


(bind (a b . rest) (list 1 2 3 4 5)
      (printf "a+b=~s rest=~s\n" (+ a b) rest))
