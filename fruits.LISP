; Regles utility functions
(load "src/modele/regles.lisp")
; Fruits utility functions
(load "src/modele/fruits.lisp")
; User interactions functions
(load "src/interface/interaction.lisp")

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