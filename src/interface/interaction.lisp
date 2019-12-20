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
