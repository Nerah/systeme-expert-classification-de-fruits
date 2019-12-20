  
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
