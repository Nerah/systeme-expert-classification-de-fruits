; --------------------------------------------------------
; Liste des regles

(setq LR nil)

(defun liste-regles ()
  LR
)

; Liste des regles activables
(setq LRA nil)

(defun liste-regles-activables ()
  LRA
)

; --------------------------------------------------------
; Regle

; Structure d'une regle
(defstruct regle nom condition action)

; Definit une nouvelle regle et l'ajoute a la liste des regles
(defun nouvelle-regle (nom condition action)
  (cond ( (regle-existe nom) (print 'existe_deja) nil )
        ( t (setq LR (cons (make-regle :nom nom :condition condition :action action) LR)) t))
)

; Retourne la regle avec un nom donne
(defun regle-avec-nom (nom)
  (loop for r in LR
        when (string= (regle-nom r) nom)
        return r)
)

; Verifie si la regle existe deja
(defun regle-existe (nom)
  (loop for r in LR thereis (string= (regle-nom r) nom))
)

; Verifie si un ensemble de regles est verifie
(defun liste-regles-existe (liste_noms)
  (loop for nom in liste_noms always (regle-existe nom))
)

; Verifie si une regle de nom donne est activable
(defun regle-est-activable (nom)
  (eval (regle-condition (regle-avec-nom nom)))
)

; Met a jour la liste des regles activables
(defun maj-regles-activables ()
  (setq LRA nil)
  (mapcar (lambda (x) (if (regle-est-activable (regle-nom x)) (setq LRA (cons x LRA)))) LR)
)

; Active une regle de nom donne
(defun regle-activer (nom)
  (eval (regle-action (regle-avec-nom nom)))
)

; Active la liste des regles activables
(defun act-regles-activables ()
  (mapcar (lambda (x) (regle-activer (regle-nom x)) LRA) LRA)
)

; --------------------------------------------------------
; Liste des fruits

(setq LF nil)

(defun liste-fruits ()
  LF
)

; --------------------------------------------------------
; Fruit

; Definit un nouveau fruit et l'ajoute a la liste des fruits
(defun nouveau-fruit (nom)
  (cond ( (member nom LF) (print 'existe_deja) nil )
        ( t (setq LF (cons nom LF)) nom ))
)

; Verifie si le fruit existe deja
(defun fruit-existe (nom)
  (cond ((member nom LF) t)
        (t nil))
)

; Verifie s'il existe au moins un fruit
(defun fruits-definis ()
  (cond ( (> (length LF) 0) t)
        (t nil))
)

; --------------------------------------------------------
; Interactions utilisateur

(defun choix(lst)
  (setq longueur (length lst))
  (cond
    ((not lst) nil)
    ((listp (car lst)) (choix (car lst)))
  )

  (loop for x from 1 to longueur
        for y in lst 
      do(format t " ~A - " x)
      do(format t "~A" y)
      (terpri)
  )
)

(defun demande-utilisateur(var lst)
  (print "choisissez votre regle : ")
  (terpri)
  (choix lst)
  (setq indice (read))
  (setq res (nth (- indice 1) lst))
  (setq var res)
)

; --------------------------------------------------------
; Définitions

; Base de faits

; Niveau 1
(setq a-jus nil)

; Niveau 2
(setq a-noyau nil)

; Niveau 3
(setq a-chair nil)

; Niveau 4
(setq a-peau nil)

;---------
; Regles

; Règle initiale - la seule activable à l'origine (c'est forcément un fruit)
(nouvelle-regle 'est-un-fruit t '(setq a-jus t))

; --------
; Règles intermédiaires - niveau 1 (avec ou sans jus)
(nouvelle-regle 'est-a-jus 'a-jus '(setq a-noyau t))


; --------
; Règles intermédiaires - niveau 2
(nouvelle-regle 'a-un-noyau 'a-noyau '(demande-utilisateur a-chair ("orange" "rouge")))

; --------
; Règles intermédiaires - niveau 3
(nouvelle-regle 'a-chair-orange '(string= a-chair "orange") '(setq a-peau "lisse"))

; --------
; Regles de fin - quand le fruit a été trouvé
(nouvelle-regle 'est-une-peche '(and a-jus a-noyau (string= a-chair "orange") (string= a-peau "lisse")) '(nouveau-fruit "peche"))


; -------------------
; Programme principal

; Tant qu'aucun fruit n'a été trouvé, on continue 
(loop until (fruits-definis)
      ; Mise à jour de la base de règles activables
      do (maj-regles-activables)
      ; Application des règles
      do (act-regles-activables)
)

; Affichage du résultat
