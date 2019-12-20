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
