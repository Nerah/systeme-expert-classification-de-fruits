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
; Tests (a retirer par la suite)

; Base de faits

(setq a-jus nil)
(setq a-noyau nil)
(setq a-chair nil)
(setq a-peau nil)

; Regles

(nouvelle-regle 'est-un-fruit t '(setq a-jus t))
(nouvelle-regle 'est-a-jus 'a-jus '(setq a-noyau t))
(nouvelle-regle 'a-un-noyau 'a-noyau '(setq a-chair "orange"))
(nouvelle-regle 'a-chair-orange '(string= a-chair "orange") '(setq a-peau "lisse"))
(nouvelle-regle 'a-chair-rouge '(string= a-chair "rouge") '(setq a-peau "rugueuse"))

; Regles de fin

(nouvelle-regle 'est-une-peche '(and (and 'a-jus 'a-noyau) (string= 'a-chair "orange")) '(nouveau-fruit "peche"))

; Enchainement des regles

;(if (regle-est-activable 'est-un-fruit)
;    (regle-activer 'est-un-fruit))
;(if (regle-est-activable 'est-a-jus)
;    (regle-activer 'est-a-jus))
;(if (regle-est-activable 'a-un-noyau)
;    (regle-activer 'a-un-noyau))
;(if (regle-est-activable 'a-chair-rouge)
;    (regle-activer 'a-chair-rouge))
;(if (regle-est-activable 'a-chair-orange)
;    (regle-activer 'a-chair-orange))

; Definition du fruit final
;(if (regle-est-activable 'est-une-peche)
;    (regle-activer 'est-une-peche))

; Condition d'arret
;(fruits-definis)