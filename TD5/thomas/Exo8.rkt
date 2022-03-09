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

(define-macro (while expr . corps)
  `(letrec ([loop (lambda ()
                    (if ,expr
                        (begin ,@corps (loop))
                        ))])
     (loop)))

(let ((i 0))
  (while (< i 5)
         (print i)
         (set! i (+ i 1))))