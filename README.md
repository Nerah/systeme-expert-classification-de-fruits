# Système expert - Classification des fruits

## Fonctionnalités

Le moteur demande à l'utilisateur des précisions sur le fruit à trouver.
A la fin, le moteur retournera le nom du fruit cherché.

## Lancer le programme

Il vous faut [CLisp 2.49](https://sourceforge.net/projects/clisp/) installé sur votre système.
Dans un terminal, entrez la commande suivante:
```
clisp main.lisp
```

## Classification des fruits

Notre classification se base sur la classification donnée par Jean Duperrex.
Vous pouvez la retrouver [en cliquant sur ce lien](http://www.jeanduperrex.ch/Site/Classification_fruits_files/Classification%20FRUITS%20Duperrex.pdf).

La classification de Jean Duperrex n'étant pas suffisante pour permettre à un système expert de retrouver un fruit spécifique d'une sous-catégorique, notre travail était de rajouter des règles afin de distinguer chaque fruit.

Le fichier Fruits.cmap vous permet de visualiser notre nouvelle classification.

## Architecture

### [main.lisp](main.lisp)
Le programme principal.
Récupère le contenu de l'ensemble des fichiers du projet et lance le moteur d'inférences.

### [src/modele](src/modele)
Les fonctions relatives aux règles et fruits sont retrouvables dans ce dossier.

### [src/interface](src/interface)
Les fonctions associées aux interactions utilisateur sont définies ici.

### [src/bases](src/bases)
La base de faits et la base de règles sont déclarées dans ce dossier.

## Sources

### Classification des fruits
http://www.jeanduperrex.ch/Site/Classification_fruits_files/Classification%20FRUITS%20Duperrex.pdf

## Auteurs

* Alexandre Ascenci
* Jia Qin
* Sabrina Khelifi