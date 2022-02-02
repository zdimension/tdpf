(define racines
  (lambda(a b c)
    (define delta
      (- (* b b) (* 4 a c)))
    (cond
      ((< delta 0) (list))
      ((= delta 0) (list (/ (- b) (* 2 a))))
      (else (list
             (/ (- (- b) (sqrt delta)) (* 2 a))
             (/ (+ (- b) (sqrt delta)) (* 2 a)))))))
(racines 1 2 1)
(racines 1 0 -1)
(racines 1 1 -6)
(racines 1 1 1)