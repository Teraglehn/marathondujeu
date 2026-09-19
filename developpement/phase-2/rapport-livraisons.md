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

## 2026-09-19 — L06

**L06 — Tirages : copie, éditeur revu, lecture seule.** Un tirage s'ouvre, s'enregistre sans
tirer, et se lance **une seule fois** (`Draw.drawnAt`) ; lancé, il se consulte en lecture seule
et se copie — la copie reprend tout et exclut le groupe « Gagnants du tirage … » créé au
lancement. `Draw` garde les groupes choisis, résolus au tirage ; les joueurs sans jeton sont hors
de l'urne, avec un compteur de jetons ; sélecteur de sessions en grille ; noms « Tirage N°n ».
*Écarts assumés* : plus de suppression de tirage ; titres sur les quatre éditeurs latéraux ;
actions passées par le service plutôt que par `drawsProvider()` ; pas de date pour les tirages
d'avant (affichés « Tiré » sans date).

## 2026-09-19 — L13

**L13 — Affichage des sessions.** La page d'une session montre deux zones de billes, *Présents*
puis *Absents* (a badgé une autre session), avec leur compte ; les joueurs jamais badgés
n'apparaissent pas. Au badgeage, la bille fait un pop out dans *Absents* puis un pop in dans
*Présents* (pop in direct au premier badgeage), détecté au rendu. En-tête : « Session n — début
à fin — Ouverte / Passée » à gauche, horloge à droite, interrupteurs *Badgeage manuel* et *Mode
suppression* (rouge), champ *Numéro* + *Ajouter* pour badger sans carte — *Supprimer* (rouge,
poubelle) en mode suppression ; champ et bouton grisés hors session ouverte, badgeage manuel ou
mode suppression ; le champ rend le focus à la douchette (Entrée, 2 s, ou code de douchette
tapé). Mode suppression : cartes bille + *Retirer* (`RemovableBubble`, partagé avec L16),
écrit tout de suite (`EventService.removePlayerFromSession`, testé). Liste : légende des
couleurs, cartes plus basses, « n présents », curseur main. `docs/gestes.md` : SE-1, SE-3, SE-6
revus, SE-8 à SE-10 ajoutés. *Écarts assumés* : Q1 (a) sans confirmation, Q2 (b) présents seuls ;
la recherche par numéro (C5) retirée, le champ n'est pas une recherche ; pas de mention
« Ouverte » sur la liste, la couleur suffit ; le retour de scan reste en `SnackBar` (L15).

## 2026-09-20 — L14

**L14 — Guidage sans événement.** Sur une page qui exige un événement sans qu'aucun soit choisi,
le sélecteur s'ouvre de lui-même à l'arrivée ; fermé sans choisir, la page montre le message et
un bouton « Choisir un événement » qui le rouvre. Aucun événement en base : les cinq entrées du
rail hors *Événements* sont grisées (infobulle « Créez d'abord un événement ») et la garde
renvoie à la liste des événements. Liste vide sans recherche : un bloc central « Créer un
événement » remplace la liste. `docs/gestes.md` : TR-1, TR-2, EV-1. *Écarts assumés* : Q1 (b),
l'événement n'est pas retenu d'un lancement à l'autre ; la redirection vit dans
`EventSelectedGuard`, pas dans le routeur (C3) ; le sélecteur ouvert d'office est celui du
bouton central, la vue s'ancre donc au milieu de la page ; `SearchSelector` suit désormais
`initialValue` (le sélecteur de la barre restait vide après un choix depuis la garde) ; le pod
`SelectedEvent` n'émet plus d'erreur silencieuse quand aucun événement n'est choisi.
