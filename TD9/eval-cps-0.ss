;;;;                                                  -*- coding: utf-8 -*-
;;;;
;;;; e v a l - c p s . s t k             -- A simple CPS Scheme Interpreter
;;;;
;;;;
;;;;           Author: Erick Gallesio [eg@unice.fr]
;;;;    Creation date:  2-Apr-2019 20:56
;;;; Last file update:  5-May-2021 12:42 (eg)

;;; Macros are not in this version to make it more compact. Adding them
;;; to the interpreter is not difficult

(load "environment.ss")

;; ======================================================================
;;
;;                       Closures Management
;;
;; A closure is implemented using a list such as
;;               (*closure* args body env)
;; ======================================================================
(define (make-closure args body env)
  (list '*closure* args body env))

(define (closure? obj)
  (and (pair? obj)
       (eq? (car obj) '*closure*)))

(define closure-args cadr)
(define closure-body caddr)
(define closure-env  cadddr)

;;========================================================================
;;
;;                       Macros Management
;;
;; A macro is implemented using a list such as
;;          (*macro* args body env)
;; ========================================================================
(define (make-macro args body env)
  (list '*macro* args body env))

(define (macro? obj)
  (and (pair? obj)
       (eq? (car obj) '*macro*)))

(define macro-args cadr)
(define macro-body caddr)
(define macro-env  cadddr)

(define (macro-expand macro args k)
  (evaluate-compound (macro-body macro)
                     (extend-env (macro-args macro)
                                 args
                                 (macro-env macro))
                     k))

;;=============================================================================
;;
;;                       Continuation Management
;;
;; A continuation is implemented using a list such as
;;               (*contination* func)
;;=============================================================================
(define (make-continuation k)
  (list '*continuation* k))

(define (kontinuation? obj)
  (and (pair? obj)
       (eq? (car obj) '*continuation*)))

(define continuation-value cadr)

;=============================================================================
;
;                       Evaluate
;
;=============================================================================
(define (evaluate-compound l env k)
  ;; Evaluate in environment env the expressions of l
  (evaluate (car l)
            env
            (λ (val)
              (if (null? (cdr l))
                  (k val)
                  (evaluate-compound (cdr l) env k)))))

(define (funcall func l env k)
  (cond
    ((closure? func)
        (evaluate-compound (closure-body func)
                           (extend-env (closure-args func)
                                       l
                                       (closure-env func))
                           k))
    ((kontinuation? func)
        (apply (continuation-value func) l))
    (else
        (k (apply func l)))))

(define (evaluate-list exps env k)
  (if (null? exps)
      (k '())
      (evaluate (car exps)
                env
                (λ (arg1)
                  (evaluate-list (cdr exps)
                                 env
                                 (λ (args) (k (cons arg1 args))))))))

(define (evaluate expr env k)
  (cond
    ((symbol? expr)
         (k (find-binding expr env)))
    ((pair?   expr)
         (case (car expr)
           ((quote)  (k (cadr expr)))
           ((begin)  (evaluate-compound (cdr expr) env k))
           ((set!)   (evaluate (caddr expr)
                               env
                               (λ (v)
                                 (k (set-binding! (cadr expr) v env #t)))))
           ((define) (evaluate (caddr expr)
                               env
                               (λ (v)
                                 (k (set-binding! (cadr expr) v env #f)))))
           ((if)     (evaluate (cadr expr)
                               env
                               (λ (v)
                                 (evaluate (if v (caddr expr) (cadddr expr))
                                           env
                                           k))))
           ((call/cc) ;; Simulate call: (v (make-continuation k))
                      (evaluate (cadr expr)
                                env
                                (λ (v) (funcall v
                                                (list (make-continuation k))
                                                env
                                                k))))
           ((lambda) (k (make-closure (cadr expr) (cddr expr) env)))
           (else     (evaluate-list expr
                                    env
                                    (λ (v) (funcall (car v) (cdr v) env k))))))
    (else
          (k expr))))


;; ======================================================================
;;
;;                    Errors
;;
;; ======================================================================
(define *top* #f)
(define (ms-error . args)
  (display "*** ERROR in Mini-Scheme: ")
  (for-each (λ (x) (display x) (display " ")) args)
  (newline)
  (*top*))


;; ======================================================================
;;
;;                         Interpreter
;;
;; ======================================================================
(define (init-interpreter)
  ;; Print banner
  (printf ";; Mini-Scheme CPS Interpreter (SI4)\n")
  (set-binding! 'error ms-error *global-env* #f)
  ;; Initialize the *top* continuation
  (call/cc (λ (k) (set! *top* k))))

(define (interp)
  (init-interpreter)

  (let Loop ()
    (display "Mini-Scheme> ")
    (let ((expr (read)))
      (unless (eof-object? expr)
        (evaluate expr
                  *global-env*
                  (λ (v)
                    (unless (eq? v (void))
                      (write v)
                      (newline))))
        (Loop))))

  (display "Bye\n"))
