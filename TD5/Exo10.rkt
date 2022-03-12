(require mzlib/defmacro)
(define-macro (macro-expand m)
  `(syntax-object->datum (expand-once ,m)))
(define-macro (macro-expand* m)
  `(syntax-object->datum (expand-to-top-form ,m)))
(define (pp form . width)
  (pretty-print-columns (if (null? width) 30 (car width)))
  (pretty-print form))

;;;;;;;;;;;;;;;;;;;;;;;;;

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

(define-macro (for params . instrs)
  `(let (
         (départ ,(cadr params))
         (fin ,(caddr params))
         (pas ,(cadddr params))
         )
     (letrec ((cmp (if (< pas 0) > <))
              (loop (lambda (,(car params))
                      (if (cmp ,(car params) fin)
                          (begin
                            ,@instrs
                            (loop (+ ,(car params) pas)))))))
       (loop départ))))

(macro-expand '(for (i (+ 3 2) 0 -1) (display i) (newline)))

(for (i 5 0 -1) (display i) (newline))
