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

## 2026-09-20 — L17

**L17 — Modifications en cours.** Fermer un éditeur latéral sans enregistrer — *Annuler* /
*Fermer*, la croix, Échap, un clic hors du tiroir — passe par une seule voie,
`EditorPod.requestClose` : si le formulaire est modifié, modale « Modification en cours »
*Revenir* / *Quitter* ; sinon fermeture directe. Chaque formulaire expose `isDirty`
(`DirtyAware`) par une fonction pure qui compare les valeurs à l'écran à l'objet ouvert — une
valeur remise ne compte pas, un champ numérique vidé compte, les badgeages manuels en attente
comptent (`forms_dirty_test.dart`). `docs/gestes.md` : TR-3 revu, EV-11, JO-12, GR-9, TI-13.
*Écarts assumés* : Q1 (a), un formulaire neuf jamais touché se ferme sans question ; le tiroir
n'est plus le `endDrawer` du `Scaffold` (celui-ci démonte son contenu avant de prévenir), c'est
un `ModalBarrier` et un `Drawer` posés par `DesktopLayout` ; `requestClose` reçoit un
`BuildContext` pour la modale ; Échap n'est capté que si le focus est dans le tiroir, et Tab
n'y est pas piégé.

## 2026-09-20 — L16

**L16 — Gestion des groupes.** `PlayerGroup.kind` (*manuel* / *gagnants*, énumération Isar) ;
les groupes d'avant le champ sont reclassés à l'ouverture de la base (ceux qu'un tirage tient
par `winnersGroup` → gagnants). La liste des groupes ne montre que les manuels, avec une ligne
d'aide ; sur chaque ligne, un crayon (éditeur) et une poubelle (suppression). Suppression
confirmée, **refusée tant qu'un tirage utilise le groupe** (exclu ou requis, préparé ou
effectué) ; un groupe de gagnants ne se supprime pas et ne se renomme pas. Page d'un groupe :
« Membres (n) », mode suppression (billes → cartes *Retirer*, composant de L13), champ
« Ajouter par numéro ». Sélecteur de groupes des tirages : trophée sur les groupes de gagnants.
Service : `addPlayer` / `removePlayer`, `countUsingGroup`, migration — testés
(`player_group_service_test.dart`). `docs/gestes.md` : GR-3, GR-5 à GR-8, GR-10, GR-11, TI-4.
*Écarts assumés* : Q1 (b) cachés, Q2 (b) refusé ; « Ajouter par numéro » cherche dans la liste
chargée, sans méthode de service, et dit « Numéro n inconnu » plutôt que « Carte invalide »
(L15) ; `SelectedPlayerGroup` notifie à chaque lecture — l'égalité par identifiant faisait
taire Riverpod et la page ne se redessinait pas (`SelectedSession` / `SelectedEvent` ont le
même défaut latent, signalé) ; la logique « rendre la main à la douchette » est recopiée de la
page de session, pas partagée.

## 2026-09-20 — L15

**L15 — Retour de scan sur toutes les pages, et gestes manquants.** Un seul retour de scan, dans
la barre du haut de chaque page (`ScanStatus`, pod `scanStatus`) : au repos, ce qu'un scan fait
sur la page (« Scanner une carte pour ouvrir la fiche joueur », « … pour badger cette
session »…) ; après un scan, ce qui s'est passé, vert ou rouge, jusqu'au scan suivant.
`PlayerSessionScanner` reçoit un mode explicite (`openPlayer` par défaut, `addToGroup`,
`badgeOpenSession`, `badgeThisSession`) et les indicateurs `manual` / `remove` ; le service
rend un `ScanResult` (`badgeOpenSession`, `badgeSession`, `unbadgeSession`, testés). Carte
inconnue → « Carte invalide » ; « déjà présent » est une information. Mode suppression (session,
groupe) : le scan **retire**, la barre passe sur fond « erreur » et clignote. Notifications en
toast centré en haut (`Toast`), les `SnackBar` disparaissent ; le champ *Numéro* dit son
résultat en toast. Joueurs : nombre ≤ existants → champ en erreur, bouton gris ; fermer la
fenêtre pendant l'écriture d'un bonus la retient. Générateur : « Générer les joueurs
supplémentaires » au-delà des joueurs. Événement : confirmation avant de regénérer des sessions
badgées (`countBadges`). Recherche des tirages retirée. `docs/gestes.md` : TR-4 revu, TR-5, EV-8,
JO-1, JO-2, JO-5, GR-4 à GR-6, GR-10, SE-2, SE-4 à SE-8, SE-10, TI-11, CA-5, CA-7 ; `CLAUDE.md` :
règle du toast, `docs/gestes.md` cité. *Écarts assumés* : sans événement sélectionné le scan dit
« Aucun événement sélectionné » (C9) ; une boîte de dialogue ouverte suspend l'écouteur de la
page (C10) ; en mode suppression tous les messages sont en `onErrorContainer` ; C6 (fermeture
retenue) : aucun écart relevé à la recette, sans constat explicite ; deux constats hors périmètre notés au
rapport (clé de message erronée sur le champ *Nombre de joueurs* vide ; un scan qui ouvre une
fiche remplace un éditeur modifié sans « Quitter / Revenir »).

## 2026-09-20 — L19

**L19 — Sessions générées d'office.** La coche *Générer les sessions* disparaît. Un événement
neuf reçoit ses sessions à l'enregistrement, par le service (`save`, quel que soit l'appelant).
Un existant les garde tant que début, fin, durée et intervalle ne changent pas
(`eventSessionsChanged`, fonction pure testée) ; changés sans badgeage → recréées sans demander ;
changés avec badgeages → modale « Recréer les sessions ? » : *Recréer les sessions* (badgeages
perdus) ou *Annuler les modifications*, qui remet les quatre champs et laisse l'éditeur ouvert.
Tests : `save` (neuf, inchangé, recréé). `docs/gestes.md` : EV-8 réécrit, EV-9, EV-11. L18 ajusté
(dépend de L19, étapes 1 et 8). *Écarts assumés* : aucun.

## 2026-09-20 — L18

**L18 — Couverture des gestes par les tests.** Un harnais (`test/e2e/app_test_support.dart`,
`App`) monte l'application entière sur une base Isar temporaire et joue les gestes d'un
organisateur — clics, frappes, scans par touches Windows — en attendant la base hors horloge
factice ; un échec nomme l'étape et le geste et imprime l'écran. Le **parcours**
(`test/e2e/parcours_test.dart`) rejoue une édition en neuf étapes et deux événements, avec
cycles : les 72 gestes de `docs/gestes.md`, en 17 s ; la colonne *Test* cite pour chacun le test
unitaire et l'étape (quatre en « recette » : image et impression du système, rendu PDF, dialogues
date / heure de Flutter). Tests unitaires ajoutés : `destroyPlayers`, `generateMissingPlayers`,
`Session.isOpenAt` ; 82 tests. **Q4** : sous Windows, `flutter_barcode_listener` lisait le code de
touche (`a` → `A`, `-` → `½`) — une carte protégée n'était pas reconnue ; remplacé par
`ScannerListener` (maison, `HardwareKeyboard`, le caractère tapé), le paquet sort. **Défauts
révélés par le parcours et corrigés** : la carte de joueur ne comptait pas les badgeages manuels
après *Enregistrer* (ordre des écritures) ; les sélecteurs de l'éditeur de tirage lisaient un pod
détruit pendant son chargement ; *Supprimer les joueurs* laissait des gagnants sans joueur (ils
partent avec). **Recette** (Bastien) : carte de joueur de taille fixe (200 × 176) rangée en
`Wrap`, bille du numéro grise sans jeton ; « Le nom est requis » (groupe, tirage, fr). *Écarts
assumés* : les débordements de mise en page sont ignorés en test (police de test plus grande que
Roboto) — carte de session et ligne du générateur à regarder sur le poste ; `google_fonts`
imprime quatre erreurs par lancement, sans effet.

## 2026-09-20 — L12

**L12 — Aide et tutoriels.** Un « i » en dernier dans la barre des huit pages (`HelpButton`) lance
un **pas à pas sur le vrai écran** (`HelpTour`, route transparente sur le navigateur racine, sans
dépendance tierce) : voile sur toute la fenêtre, trou autour de l'élément visé (clé de widget,
amené à l'écran puis mesuré), bulle, compteur, *Suivant* / *Terminer*, *Passer*, croix, Échap. Les
pas se construisent à l'ouverture avec les données de la page : liste vide → où les choses
apparaîtront ; session ouverte → sa carte ; tirage effectué → le cadenas ; cible absente → pas
sauté. De 5 à 9 pas par page, 60 textes fr/en (`help_<page>_n`), rédigés par Claude, corrigés à
la recette. Petits « i » à infobulle (`HelpHint`) sur *Nombre de joueurs*, *Badgeage manuel*,
*Numéro*, *Mode suppression*, *Ajouter par numéro* ; légende de la liste des joueurs (jetons, bille
grise). La douchette est muette pendant le pas à pas et reprend après — le garde-fou vaut aussi
pour les boîtes de dialogue, qui vivent sur le même navigateur (ce que TR-4 décrivait sans que le
test `isCurrent` le fasse). `docs/gestes.md` : TR-6, étape 10 du parcours (neuf pas, scan pendant
et après, Échap, *Passer*) ; 73 gestes, 85 tests. *Écarts assumés* : C2 (trois parties → l'ordre
des pas) et C5 (une étape e2e pour TR-6) amendés ; les cibles des sections du générateur sont
leurs titres. **Q2** tranchée *(b)* : le guide global du parcours d'une édition est **L12b**.

**Retouche hors lot, même commit (Bastien, 2026-09-20)** — éditeur d'événement : *Début* et *Fin*
sur une ligne, *Durée* et *Intervalle* sur la suivante ; dessous, l'**aperçu des sessions** que
ces valeurs donneront, refait à chaque saisie — nombre, première, deuxième, « … », dernière (jour
et heure). Le calcul est celui de la génération, extrait en `EventService.sessionStarts`
(fonction pure testée) ; l'aperçu ne peut pas mentir. `docs/gestes.md` : EV-3.
