(load "eval-cps-0.ss")

(init-interpreter)
(evaluate '(with-return
              (print "Hello")
              (print "World")
              "END")
          *global-env*
          print)