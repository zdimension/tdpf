(define *top* #f)
(call/cc (lambda (k) (set! *top* k)))

(define *threads* #f)

(define (init-threads) (set! *threads* (list)))

(init-threads)

(define (release) (call/cc (lambda(k) (create-thread! k))) (scheduler))

(define (create-thread! th) (set! *threads* (append *threads* (list th))))

(define (scheduler)
  (let ((next (car *threads*)))
    (set! *threads* (cdr *threads*))
    (next)))

(create-thread! (λ () (display "In thread 1\n")))
(create-thread! (λ () (display "In thread 2\n")))
(displayln "a")
(scheduler)
(displayln "b")
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