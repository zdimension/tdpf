(define (vide) (lambda(x) #f))
(define (entiers) (lambda(x) #t))
(define (multiple k) (lambda(x) (= (modulo x k) 0)))
(define (singleton k) (lambda(x) (= x k)))
(define (intervalle m n) (lambda(x) (and (>= x m) (<= x n))))

(define (appartient? n ens) (ens n))

(define (union . ens)
  (lambda(x) (foldl (lambda(f res) (or (f x) res)) #f ens)))

(define (intersection . ens)
  (lambda(x) (foldl (lambda(f res) (and (f x) res)) #t ens)))

(define (complementaire ens) (compose not ens))

(define (difference a b)
  (lambda(x) (and (a x) (not (b x)))))

(define N       (entiers))
(define Pairs   (multiple 2))
(define Impairs (lambda(x) (not (multiple 2))))
(define only-42 (singleton 42))

(printf "42 ∈ ℕ ⟹ ~a\n"       (appartient? 42 N))
(printf "42 ∈ ∅ ⟹ ~a\n"       (appartient? 42 (vide)))
(printf "42 ∈ Pairs ⟹ ~a\n"   (appartient? 42 Pairs))
(printf "42 ∈ Impairs ⟹ ~a\n" (appartient? 42 Impairs))
(printf "42 ∈ only-42 ⟹ ~a\n" (appartient? 42 only-42))
(printf "1 ∈ only-42 ⟹ ~a\n"  (appartient? 1 only-42))

(define fizz (multiple 3))
(define buzz (multiple 5))
(define fizz-buzz (union fizz buzz))

(printf "29 ∈ fizz-buzz ⟹ ~a\n" (appartient? 29 fizz-buzz))
(printf "30 ∈ fizz-buzz ⟹ ~a\n" (appartient? 30 fizz-buzz))
(printf "18 ∈ fizz-buzz ⟹ ~a\n" (appartient? 18 fizz-buzz))

(define fizz-buzz (intersection fizz buzz))
(printf "29 ∈ fizz-buzz ⟹ ~a\n" (appartient? 29 fizz-buzz))
(printf "30 ∈ fizz-buzz ⟹ ~a\n" (appartient? 30 fizz-buzz))
(printf "18 ∈ fizz-buzz ⟹ ~a\n" (appartient? 18 fizz-buzz))

(define compl (complementaire fizz-buzz))
(printf "29 ∈ !fizz-buzz ⟹ ~a\n" (appartient? 29 compl))
(printf "30 ∈ !fizz-buzz ⟹ ~a\n" (appartient? 30 compl))
(printf "18 ∈ !fizz-buzz ⟹ ~a\n" (appartient? 18 compl))