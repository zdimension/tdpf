(define *top* #f)
(call/cc (lambda (k) (set! *top* k)))

(define *threads* #f)

(define (init-threads) (set! *threads* (list)))

(init-threads)

(define (release) (call/cc (lambda(k) (create-thread! k) (scheduler))))

(define (create-thread! th) (set! *threads* (append *threads* (list (lambda () (th 'unused) (release))))))

(define (scheduler)
  (unless (null? *threads*)
    (let ((next (car *threads*)))
      (set! *threads* (cdr *threads*))
      (next))))

(create-thread! (λ () (display "In thread 1\n")))
(create-thread! (λ () (display "In thread 2\n")))
(scheduler)
(scheduler)
(displayln "---")
(init-threads)
(create-thread!
 (λ ()
   (printf "Start of #1\n")
   (release)
   (printf "End of #1\n")))

(create-thread!
 (λ ()
   (printf "Start of #2\n")
   (release)
   (printf "End of #2\n")))

(scheduler)
(displayln "---")
(init-threads)
(define (make-thread name)
    (create-thread!
     (λ ()
       (let Loop ((i 0))
         (when (< i 10)
           (printf "[Thread ~s ~s] " name i)
           (release)
           (Loop (+ i 1)))))))
(for-each make-thread '(A B C D E))
(scheduler)