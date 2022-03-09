(require mzlib/defmacro)
(define-macro (macro-expand m)
  `(syntax-object->datum (expand-once ,m)))
(define-macro (macro-expand* m)
  `(syntax-object->datum (expand-to-top-form ,m)))
(define (pp form . width)
  (pretty-print-columns (if (null? width) 30 (car width)))
  (pretty-print form))

;;;;;;;;;;;;;;;;;;;;;;;;;


(define (nth n l)
  (if (or (> n (length l)) (< n 0))
    (error "Index out of bounds.")
    (if (eq? n 0)
      (car l)
      (nth (- n 1) (cdr l)))))

(define-macro (for var_depart_fin_pas . instrs)
  `(let ((var_name_as_str (nth 0 '(,@var_depart_fin_pas))))
     (let ((depart (nth 1 '(,@var_depart_fin_pas))))
       (let ((fin (nth 2 '(,@var_depart_fin_pas))))
         (let ((pas (nth 3 '(,@var_depart_fin_pas))))
           (begin
             (namespace-set-variable-value! var_name_as_str depart)
             (letrec ([rec-fun (lambda ()
                                 (if (not (eq? fin (namespace-variable-value var_name_as_str)))
                                   (begin
                                     ,@instrs
                                     (namespace-set-variable-value! var_name_as_str (+ (namespace-variable-value var_name_as_str) pas))
                                     (rec-fun)
                                     ))
                               )])
             (rec-fun)
             )
           )
           ))))
  )


(define-macro (for params . instrs)
  `(let (
         (départ ,(cadr params))
         (fin ,(caddr params))
         (pas ,(cadddr params)))
     (let ((i 0) (cmp (if (< pas 0) <= >=)))
       (set! ,(car params) départ)
       (letrec ((loop (lambda ()
                        (if (not (cmp ,(car params) fin))
                            (begin
                              ,@instrs
                              (set! ,(car params) (+ ,(car params) pas))
                              (loop)
                              ))
                        )))
         (loop)))))


(macro-expand '(for (i (+ 3 2) 0 -1) (display i) (newline)))

(for (i 5 0 -1) (display i) (newline))
