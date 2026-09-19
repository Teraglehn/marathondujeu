# Les gestes de l'application

Dernière mise à jour : 2026-09-19. **Document de référence** (voir `docs/methode-de-travail.md`,
partie II) : il décrit ce que l'application permet de faire, page par page — la cible telle
qu'elle est aujourd'hui dans le code livré.

**À quoi il sert** : chaque geste sera **appairé à un tutoriel** (l'aide de la page) **et à des
tests** (Bastien, 2026-09-19). Un geste absent d'ici n'a ni aide ni test ; un geste qui change
se met à jour ici d'abord.

**Comment lire** : chaque page ouvre par ses **paramètres d'état** — ce qui change le
comportement des gestes. Chaque geste a un identifiant stable (`XX-n`, jamais réattribué), ses
**variantes** selon les paramètres, et son **effet observable** — ce qu'un test constate. La
colonne *Test* dit ce qui existe : `service` (testé sur base Isar), `—` (rien encore).

Ce document cite le code ; le code ne le cite pas.

---

## Transversal (toutes les pages)

Paramètres : **événement sélectionné** (oui / non) · **éditeur latéral ouvert** (oui / non) ·
**douchette** (branchée ou non — un scan est une frappe clavier terminée par Entrée).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **TR-1** Choisir une page dans le rail de gauche (six entrées : Événements, Joueurs, Groupes, Sessions, Tirages, Générateur de carte) | — | la page s'affiche ; l'entrée est marquée | — |
| **TR-2** Choisir l'événement courant dans la barre du haut (cinq pages : joueurs, groupes, sessions, tirages, générateur) | événement choisi / effacé | toutes les pages travaillent sur cet événement ; effacé → la page affiche « Veuillez sélectionner un évènement » et rien d'autre (`EventSelectedGuard`) | — |
| **TR-3** Fermer l'éditeur latéral : *Annuler* / *Fermer*, la croix du titre, un clic hors du tiroir | modifications faites ou non | rien n'est enregistré ; le tiroir se ferme | — |
| **TR-4** Scanner une carte (douchette) sur une page qui écoute (joueurs, groupes, un groupe, sessions, une session) | carte connue / inconnue ; événement sélectionné ou non | selon la page (voir chaque page) ; carte inconnue ou sans événement → rien ne se passe, sans message | — |

---

## Événements

Paramètres : **événement neuf / existant** · **des joueurs existent** (oui / non) · **protection
des cartes** (allumée / éteinte) · **sessions existantes** (oui / non).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **EV-1** Créer un événement (bouton « + ») | — | l'éditeur s'ouvre, titre *Créer un événement*, champs vides, dates par défaut (maintenant, +1 jour) | — |
| **EV-2** Ouvrir un événement (clic sur sa ligne) | — | l'éditeur s'ouvre, titre *Modifier un événement*, champs remplis | — |
| **EV-3** Renseigner nom, début, fin, durée de session (min), intervalle de session (min) | champ vide → message « … est requis » à l'enregistrement | — | — |
| **EV-4** Allumer *Protéger les cartes contre la copie et la réutilisation* | des joueurs existent → interrupteur **grisé**, texte « Des joueurs existent déjà… » | un code secret (8 caractères) est tiré ; les cartes et joueurs générés ensuite portent `sel-numéro` (`Event.qrCodeFor`) | service (`qrCodeFor`, `saltFromCode`) |
| **EV-5** Éteindre la protection | idem grisé si joueurs | le sel est vidé ; les codes redeviennent le numéro seul | — |
| **EV-6** *Récupérer la protection depuis une carte imprimée* | visible seulement **sans joueur** ; carte protégée / non protégée | boîte « Scannez une carte… » ; carte protégée → interrupteur allumé avec son sel ; non protégée → message « Cette carte n'a pas de protection » | service (`saltFromCode`) |
| **EV-7** *Supprimer les joueurs* | visible seulement **avec joueurs** ; confirmer / annuler | confirmation avec le nombre ; confirmé → plus aucun joueur, badgeages et gagnants perdus, protection déverrouillée | — |
| **EV-8** Cocher *Générer les sessions (supprime les sessions existantes)* puis *Enregistrer* | sessions existantes ou non | les sessions sont recréées de début à fin, une toutes les *intervalle* minutes, longues de *durée* ; les badgeages des anciennes sont perdus | — |
| **EV-9** *Enregistrer* | neuf / existant ; EV-8 coché ou non | l'événement apparaît ou se met à jour dans la liste ; le tiroir se ferme | — |
| **EV-10** *Supprimer* (dans l'éditeur d'un événement existant) | — | *(non proposé : le tiroir ouvre l'éditeur sans suppression)* | — |

---

## Joueurs

Paramètres : **joueurs existants** (n) · **bonus** du joueur (0 / > 0) · **éditeur ouvert sur le
même joueur** (oui / non) · **protection** (allumée / éteinte).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **JO-1** Saisir un *Nombre de joueurs* puis *Générer les joueurs manquants* | nombre ≤ existants → rien ; > → complète | des joueurs numérotés de n+1 à N apparaissent, code `sel-numéro` ou numéro seul | — |
| **JO-2** « + » sur la ligne *Bonus* d'une carte | — | bonus +1 et *jetons* +1 tout de suite ; enregistré 400 ms après le dernier clic, ou en quittant la page | — |
| **JO-3** « − » sur la ligne *Bonus* | bonus 0 → bouton **désactivé** | bonus −1, jetons −1 | — |
| **JO-4** Ouvrir la fiche d'un joueur (clic sur la carte, hors boutons) | — | tiroir *Modifier un joueur* : image du code, numéro, nom, bonus, sessions | — |
| **JO-5** Scanner une carte | connue / inconnue | connue → la fiche du joueur s'ouvre, **sans badger** | — |
| **JO-6** Lire une carte : billes *sessions*, *bonus*, *jetons* | valeur 0 → bille **grisée** | jetons = sessions badgées + bonus | — |

### Fiche joueur (éditeur latéral)

Paramètres : **badgeage manuel** (éteint / allumé) · session **badgée / non badgée** ·
session **passée / à venir**.

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **JO-7** Modifier le nom | vide → « Le nom est requis » | — | — |
| **JO-8** « − » / « + » / saisie du bonus | « − » désactivé à 0 ; saisie non numérique refusée | valeur du champ ; **rien en base avant *Enregistrer*** | — |
| **JO-9** Allumer *Badgeage manuel* | — | les cartes de session deviennent cliquables (curseur main) | — |
| **JO-10** Cliquer une session en badgeage manuel | badgée → devient absente ; absente → devient présente ; badgeage manuel éteint → rien | bille verte / grise dans la fiche ; **rien en base avant *Enregistrer*** | service (`setPlayerSessions`) |
| **JO-11** *Enregistrer* | avec / sans badgeages en attente | nom, bonus, badgeages écrits en une fois ; la carte du joueur et la page session le reflètent ; tiroir fermé | service |
| **JO-12** *Annuler* | — | rien n'a changé, badgeages en attente jetés | — |
| **JO-13** Lire la fiche : légende présent / absent / badgeage manuel ; aide du bonus | session passée → carte grise | — | — |

---

## Groupes

Paramètres : **groupes existants** (n) · **joueurs dans le groupe** (n).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **GR-1** Créer un groupe (bouton « + », événement sélectionné) | — | tiroir *Créer un groupe de joueurs* : un nom | — |
| **GR-2** Nommer, *Enregistrer* | nom vide → message requis | le groupe apparaît dans la liste, vide | — |
| **GR-3** Ouvrir un groupe (clic sur sa ligne) | — | la page du groupe : billes des joueurs membres, avec leur numéro ; bouton retour | — |
| **GR-4** Scanner une carte sur la liste des groupes | — | notification « Joueur n a été scanné » — *(sans effet sur un groupe : geste sans objet ici)* | — |
| **GR-5** Scanner une carte sur la page d'un groupe | déjà membre / pas encore | le joueur rejoint le groupe ; déjà membre → inchangé | — |
| **GR-6** Retirer un joueur d'un groupe | — | *(non proposé aujourd'hui)* | — |
| **GR-7** Supprimer un groupe | — | *(non proposé : le tiroir ouvre l'éditeur sans suppression)* | — |
| **GR-8** Les groupes « Gagnants du tirage « … » » | créés par un tirage lancé (TI-8) | apparaissent dans la liste comme les autres | service |

---

## Sessions

Paramètres : **heure courante** vs session (à venir / **ouverte** / passée) · **badgeage
manuel** (éteint / allumé) · joueur **déjà badgé** ou non.

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **SE-1** Lire la liste : cartes numéro, début, fin, « n présents » ; horloge ; légende des couleurs | ouverte → couleur primaire ; passée → grise ; à venir → blanche | — | — |
| **SE-2** Scanner une carte sur la liste des sessions | une session ouverte / aucune ; déjà badgé | ouverte → le joueur y est badgé, notification ; aucune session ouverte → rien ; déjà badgé → rien | service (`addPlayerToOpenedSession`) |
| **SE-3** Ouvrir une session (clic sur sa carte) | — | la page de la session : en-tête « Session n — début à fin — Ouverte / Passée » (rien pour une session à venir) à gauche, horloge à droite ; interrupteur *Badgeage manuel*, champ *Numéro* + bouton *Ajouter* (badger sans carte), interrupteur *Mode suppression* ; deux zones de billes (numéro) : **Présents** (vert) puis **Absents** (gris, ont badgé une autre session) ; les joueurs jamais badgés n'apparaissent pas ; bouton retour | — |
| **SE-4** Scanner une carte sur la page d'une session, badgeage manuel **éteint** | session ouverte / non ouverte | ouverte → badgé sur **cette** session (elle est l'ouverte), notification ; non ouverte → **rien** | service |
| **SE-5** Allumer l'interrupteur *Badgeage manuel* puis scanner | session ouverte ou non ; déjà badgé | badgé sur **cette** session quelle que soit l'heure ; déjà badgé → rien | service (`forceAddPlayerToSession`) |
| **SE-6** Dé-badger un joueur depuis la page d'une session | *Mode suppression* allumé | chaque bille présente devient une carte bille + *Retirer* ; *Retirer* → le joueur passe dans Absents (ou disparaît s'il n'a badgé nulle part ailleurs), écrit tout de suite, sans confirmation ; éteindre → billes | service (`removePlayerFromSession`) |
| **SE-7** Générer / supprimer les sessions | — | *(non proposé sur cette page : voir EV-8 ; les textes existent, sans bouton)* | — |
| **SE-8** Taper un numéro dans *Numéro* puis *Ajouter* (ou Entrée) — badger sans carte | session ouverte ou badgeage manuel allumé / ni l'un ni l'autre ; numéro inconnu | le joueur est badgé sur **cette** session (SE-9 pour l'animation), le champ se vide ; champ et bouton grisés hors session ouverte, badgeage manuel ou mode suppression ; inconnu → « Numéro n inconnu ». Le champ rend le focus à la douchette : à Entrée, après 2 s sans saisie, ou dès qu'un code de douchette s'y tape (le champ se vide, le scan fait son effet normal) | service (`forceAddPlayerToSession`) |
| **SE-9** Badgeage réussi sur la page d'une session (SE-4, SE-5, SE-8) | le joueur était dans Absents / jamais badgé | dans Absents : sa bille rétrécit et disparaît, puis grossit dans Présents ; jamais badgé : elle grossit dans Présents ; le compte de la zone suit | — |
| **SE-10** En *Mode suppression* (interrupteur et libellé en rouge), le bouton devient *Supprimer* (rouge, poubelle) ; *Supprimer* (ou Entrée) avec un numéro | présent / absent ; inconnu | le joueur est retiré de cette session, le champ se vide ; absent → rien ; inconnu → « Numéro n inconnu » | service (`removePlayerFromSession`) |

---

## Tirages

Paramètres : tirage **neuf / préparé / effectué** · **joueurs éligibles** (0 / n) · **jetons dans
l'urne** (0 / n) · **groupes existants** · **gagnants** du tirage (0 / n).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **TI-1** Créer un tirage (bouton « + ») | — | tiroir *Créer un tirage* : nom « Tirage N°n », 1 gagnant, min 1 session, **dernière session requise** | service (`createDraw`) |
| **TI-2** Ouvrir un tirage (clic sur sa ligne) | préparé → *Modifier un tirage* ; effectué → *Consulter un tirage*, champs grisés, sélecteurs ouvrables mais figés | les choix enregistrés sont retrouvés (groupes, sessions, min / max, gagnants) | — |
| **TI-3** Régler nom, nombre de gagnants, min / max de sessions | valeurs non numériques refusées | les compteurs *joueurs* et *jetons* se recalculent | service (`getEligibilityFor`) |
| **TI-4** Choisir des groupes exclus / requis | groupes résolus **au lancement**, pas à la préparation | compteurs recalculés ; requis vide = tous | service |
| **TI-5** Choisir des sessions exclues / requises (grille, recherche par numéro) | — | compteurs recalculés | service |
| **TI-6** Lire les compteurs : *n joueurs sélectionnés*, *m jetons dans l'urne* | joueur sans jeton → hors compte | jetons = somme des jetons des éligibles | service |
| **TI-7** *Enregistrer* | neuf / préparé | le tirage est dans la liste, **préparé**, sans gagnant ; rien n'est tiré | service (`save`) |
| **TI-8** *Tirer au sort* | confirmation (gagnants, joueurs) ; 0 éligible ; tirage déjà effectué (refusé par le service) | gagnants désignés par poids (jetons), affichés N°1, N°2… ; **date posée** ; groupe *Gagnants du tirage « … »* créé ; le tirage passe en lecture seule ; 0 éligible → effectué sans gagnant, sans groupe | service (`calculateDraw`, `getWinner`) |
| **TI-9** *Copier* (icône dans la liste, ou bouton d'un tirage consulté) | source préparée / effectuée | tiroir *Créer un tirage* sur une copie **non enregistrée** : mêmes réglages, nom « Tirage N°n », et le groupe des gagnants de la source parmi les groupes exclus (si effectuée) | service (`createDrawFromDraw`) |
| **TI-10** Cliquer un gagnant | — | la fiche du joueur s'ouvre | — |
| **TI-11** Rechercher un tirage (champ en haut) | — | *(le champ existe ; la liste ne filtre pas — constat 2026-09-19)* | — |
| **TI-12** Supprimer un tirage | — | *(non proposé — acté 2026-09-19, L06)* | — |

---

## Générateur de carte

Paramètres : **image de fond** (absente / présente) · **réglages enregistrés** (oui / non) ·
**protection** (allumée / éteinte) · **aperçu** (rapide / PDF).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **CA-1** Choisir une image de fond (clic sur le cadre) | image absente → « Choisissez une image de fond pour voir l'aperçu » | l'aperçu rapide apparaît ; la hauteur de carte suit le ratio de l'image | — |
| **CA-2** Régler la planche : cartes par ligne, lignes par page, portrait / paysage, largeur de carte (mm), marge de page, espaces, couleur de fond de page | décimales avec virgule ou point ; valeur non numérique ignorée | l'aperçu rapide suit chaque frappe ; hauteur affichée « Hauteur : x mm, selon l'image » | service (`CardLayout`) |
| **CA-3** Régler le QR code : taille, position X / Y, fond optionnel (case + couleur), marge du fond | — | idem | — |
| **CA-4** Régler le numéro : position, taille de police, couleur, fond optionnel, marge | — | idem | — |
| **CA-5** Choisir la plage *Du numéro* / *Au numéro* | fin < début → une carte ; plage non multiple → **complétée** | ligne « n cartes, du numéro a au numéro b, sur p pages » | service |
| **CA-6** Basculer *Aperçu rapide* / *Aperçu PDF* | — | rapide : première page, immédiat ; PDF : toutes les pages, telles qu'imprimées, imprimable | — |
| **CA-7** *Enregistrer* | — | réglages et image (réduite à 300 dpi de la largeur de carte) écrits sur l'événement ; notification 2 s ; retrouvés au redémarrage | service (`CardSettings`) |
| **CA-8** Lire le code d'une carte imprimée à la douchette | protection allumée / éteinte | le joueur de ce numéro est reconnu (JO-5, SE-2…) — protection allumée : seulement si le sel est celui de l'événement | service (`qrCodeFor`) |
| **CA-9** Imprimer | depuis l'aperçu PDF | dialogue d'impression du système | — |

---

## Ce que ce relevé montre (2026-09-19)

Gestes **sans effet ou absents** aujourd'hui, à trancher lot par lot : EV-10, GR-4, GR-6, GR-7,
SE-7, TI-11. Aucun geste d'interface n'a de test de widget : les tests couvrent les
services (`test/`) ; l'appairage geste ↔ test est à construire.
