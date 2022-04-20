(load "eval.ss")

(let ((init-orig init-interpreter)
      (*top* #f))

  (set! init-interpreter
        (lambda()
          (init-orig)
          (call/cc (lambda(k) (set! *top* k)))))

  (set! ms-error (lambda(x y)
                   (printf "~a ~a~n" x y)
                   (*top*))))