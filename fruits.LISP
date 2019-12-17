  
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

; Met a jour la liste des regles activables et retire de la liste des regles (pour eviter de repasser dans la meme regle plusieurs fois)
(defun maj-regles-activables ()
  (setq LRA nil)
  (mapcar (lambda (x) (if (regle-est-activable (regle-nom x)) (setq LRA (cons x LRA)))) LR)
)

; Active une regle de nom donne et la rend inactivable à nouveau
(defun regle-activer (nom)
  (eval (regle-action (regle-avec-nom nom)))
  (setf (regle-condition (regle-avec-nom nom)) nil)
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

(defun demande-utilisateur(lst)
  (print "choisissez votre regle : ")
  (terpri)
  (choix lst)
  (setq indice (read))
  (setq res (nth (- indice 1) lst))
  res
)

; --------------------------------------------------------
; Definitions

; Base de faits

(setq jus nil)
(setq noyau nil)
(setq chair nil)
(setq peau nil)
(setq gout nil)
(setq coquille nil)

;---------
; Regles

; Regle initiale - la seule activable a l'origine (c'est forcement un fruit)
(nouvelle-regle 'est-un-fruit t '(setq jus t))

; --------
; Regles intermediaires - niveau 1 (avec ou sans jus)
(nouvelle-regle 'jus 'jus '(setq noyau t))

; --------
; Regles intermediaires - niveau 2
(nouvelle-regle 'a-un-noyau 'noyau '(setq chair (demande-utilisateur '("chair orange" "chair jaune-marron-kaki" "chair rouge" "pas de chair"))))

; --------
; Regles intermediaires - niveau 3
(nouvelle-regle 'chair-orange '(string= chair "chair orange") '(setq peau (demande-utilisateur '("peau lisse" "peau duveteuse"))))
(nouvelle-regle 'chair-jaune-marron-kaki '(string= chair "chair jaune-marron-kaki") '(setq gout (demande-utilisateur '("gout sucre" "gout sale"))))
(nouvelle-regle 'pas-de-chair '(string= chair "pas de chair") '(setq coquille t))

; --------
; Regles de sortie - quand le fruit est trouve
(nouvelle-regle 'est-un-abricot '(and jus noyau (string= chair "chair orange") (string= peau "peau lisse")) '(nouveau-fruit "abricot"))
(nouvelle-regle 'est-une-peche '(and jus noyau (string= chair "chair orange") (string= peau "peau duveteuse")) '(nouveau-fruit "peche"))
(nouvelle-regle 'est-une-prune '(and jus noyau (string= chair "chair jaune-marron-kaki") (string= gout "gout sucre")) '(nouveau-fruit "prune"))
(nouvelle-regle 'est-une-olive '(and jus noyau (string= chair "chair jaune-marron-kaki") (string= gout "gout sale")) '(nouveau-fruit "olive"))
(nouvelle-regle 'est-une-cerise '(and jus noyau (string= chair "chair rouge")) '(nouveau-fruit "cerise"))
(nouvelle-regle 'est-une-noix '(and jus noyau (string= chair "pas de chair") coquille) '(nouveau-fruit "noix"))


; -------------------
; Programme principal

; Message
(print "Ce programme determine le fruit que vous avez sous la main.")
(print "Il vous proposera plusieurs choix. A vous de selectionner le choix qui correspond le plus a votre fruit.")
(terpri)

; Tant qu'aucun fruit n'a ete trouve, on continue 
(loop until (fruits-definis)
      ; Mise à jour de la base de règles activables
      do (maj-regles-activables)
      ; Application des règles
      do (act-regles-activables)
)

; Affichage du resultat
(print (liste-fruits))