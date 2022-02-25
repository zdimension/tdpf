(define (vide) 'vide)
(define (vide? arbre) (equal? (vide) arbre))

(define (arbre racine gauche droite) (list racine gauche droite))
(define (racine arbre) (car arbre))
(define (gauche arbre) (car (cdr arbre)))
(define (droite arbre) (car (cdr (cdr arbre))))

(define (ajouter val a)
  (if (vide? a)
      (arbre val (vide) (vide))
      (let ([rac (racine a)])
        (cond
          ((< val rac) (arbre rac (ajouter val (gauche a)) (droite a)))
          ((> val rac) (arbre rac (gauche a) (ajouter val (droite a))))
          (else a)))))

(define (appartient? val a)
  (if (vide? a)
      #f
      (let ([rac (racine a)])
        (cond
          ((< val rac) (appartient? val (gauche a)))
          ((> val rac) (appartient? val (droite a)))
          (else #t)))))

(define (construire a liste)
  (if (null? liste) a
      (construire (ajouter (car liste) a) (cdr liste))))

(define (parcourir a)
  (if (vide? a)
      (list)
      (append (parcourir (gauche a)) (list (racine a)) (parcourir (droite a)))))

(define (trier liste)
  (parcourir (construire (vide) liste)))

(define (construire-ajouter <)
  (define aux (lambda (val a)
                (if (vide? a)
                    (arbre val (vide) (vide))
                    (let ([rac (racine a)])
                      (if
                       (< val rac)
                       (arbre rac (aux val (gauche a)) (droite a))
                       (arbre rac (gauche a) (aux val (droite a))))))))
  aux)