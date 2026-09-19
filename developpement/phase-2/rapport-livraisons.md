# Phase 2 — rapport de livraisons

Une synthèse courte par lot livré : ce qui a été livré, et les écarts assumés. Le détail reste dans
le rapport du lot, dans `livraisons/`.

## 2026-09-19 — L04

**L04 — Liste des gagnants d'un tirage.** Le `Row` des cartes de gagnants devient un `Wrap`, cartes
à largeur de contenu, triées par position ; la liste des tirages défile. *Écart assumé* : aucun.
Une suggestion (nom du joueur) écartée — les joueurs sont anonymes.

## 2026-09-19 — L10

**L10 — Bonus d'un joueur : « + » et « − ».** Deux boutons sur la tuile *Bonus* de chaque carte
de la liste (sauvegarde regroupée 400 ms après le dernier clic) et à droite du champ *Bonus* de
l'éditeur latéral (pris en compte à *Enregistrer*) ; borne basse à 0. Les billes de compteur
sont grisées à zéro. *Écart assumé* : la sauvegarde dans la liste est différée, pas immédiate —
sauvegarder à chaque clic rechargeait toute la liste. Une suggestion : `DrawService.getWinner`
plante si aucun joueur éligible n'a de jeton.

## 2026-09-19 — L11

**L11 — Fiche joueur.** L'éditeur latéral du joueur montre son QR code (200 px, code dessous),
le nom, le bonus avec son aide, et les sessions de l'événement en cartes — bille verte quand le
joueur a badgé, légende dessous. Un interrupteur *Badgeage manuel* rend les cartes cliquables :
les badgeages et dé-badgeages attendent *Enregistrer* (`EventService.setPlayerSessions`, testé),
*Annuler* les jette. *Écarts assumés* : les boutons *Enregistrer* / *Annuler* / *Supprimer*
sont refaits dans les quatre éditeurs latéraux ; « Mode manuel » devient « Badgeage manuel »
aussi sur la page session ; `PlayerSessionScanner` perd sa `UniqueKey` (le défilement de la
liste des joueurs repartait en haut à chaque rebuild). Décision consignée dans `CLAUDE.md` :
public non technique, chaque écran s'explique — L12 ouvert.

## 2026-09-19 — L05

**L05 — Génération des cartes paramétrable.** La page du générateur devient un panneau de
réglages (tout en mm décimaux, couleurs, fonds, marges, espaces, orientation, plage de numéros)
à côté d'un aperçu rapide Flutter, avec l'aperçu PDF sur demande ; tout est enregistré sur
`Event`, image de fond réduite comprise. Le QR code porte `sel-numéro` ; la protection des cartes
est un interrupteur du formulaire d'événement, verrouillé dès que des joueurs existent,
récupérable depuis une carte imprimée. *Écarts assumés* : panneau fixe plutôt que tiroir ;
`flex_color_picker` rétrogradé en 3.8 (la 4 est sur `material_ui` — question transversale
ouverte) ; `Player.number` séparé du QR code, avec migration à l'ouverture de la base ;
suppression des joueurs depuis le formulaire d'événement. Non constaté : la lecture d'une carte
protégée à la douchette.
