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

(define-macro (case expr . clauses)
  `(let ((val ,expr))
     (cond
       ,@(map (λ (clause)
                (if (eq? 'else (car clause))
                    clause
                    `((memv val ',(car clause)) ,@(cdr clause))))
              clauses))))

(case (+ 2 3)
  ((1 2 3 4) 'petit)
  ((5 6 7 8) 'moyen)
  (else      'grand))