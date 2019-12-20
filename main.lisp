; Regles utility functions
(load "src/modele/regles.lisp")
; Fruits utility functions
(load "src/modele/fruits.lisp")
; User interactions functions
(load "src/interface/interaction.lisp")

; Base de faits
(load "src/bases/base_faits.lisp")
; Base de regles
(load "src/bases/base_regles.lisp")

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