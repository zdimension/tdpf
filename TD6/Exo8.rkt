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

(define-macro (define-record name fields)
  `(define (,name)
     (let ,(map (lambda (f) (list f #f)) fields)
       (lambda (msg . args)
         (case msg
           ((type) ',name)
           ((print) (printf "#<~a" ',name)
                    ,@(map (lambda (f) `(printf " ~a=~s" ',f ,f)) fields)
                    (printf ">\n"))
           ,@(map (lambda (f) `((,(string->symbol (format "get-~a" f))) ,f)) fields)
           ,@(map (lambda (f) `((,(string->symbol (format "set-~a!" f))) (set! ,f (car args)))) fields)
           (else (error "Accesseur inconnu" msg)))))))

(define-macro (make-record name . fields)
  (letrec ((proc (lambda (lst)
                   (if (null? lst) '()
                   (cons `(rec ',(string->symbol (format "set-~a!" (cadr (car lst)))) ,(cadr lst)) (proc (cddr lst)))))))
    `(let ((rec (,name)))
       ,@(proc fields)
       rec)))
     


(pp (macro-expand '(define-record Point  (x y))))
(define-record Point (x y))
(define p (make-record Point))
(p 'type)
(p 'set-x! 12)
(p 'print)
(define p2 (make-record Point 'y 20 'x 0))
(p2 'print)
(define p3 (make-record Point 'y 100))
(p3 'print)

(define-record Point (x y))
((make-record Point)              'print)
((make-record Point 'x 10)        'print)
((make-record Point 'x 10 'y 20)  'print)