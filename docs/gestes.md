# Les gestes de l'application

Dernière mise à jour : 2026-09-20 (L21). **Document de référence** (voir `docs/methode-de-travail.md`,
partie II) : il décrit ce que l'application permet de faire, page par page — la cible telle
qu'elle est aujourd'hui dans le code livré.

**À quoi il sert** : chaque geste sera **appairé à un tutoriel** (l'aide de la page) **et à des
tests** (Bastien, 2026-09-19). Un geste absent d'ici n'a ni aide ni test ; un geste qui change
se met à jour ici d'abord.

**Comment lire** : chaque page ouvre par ses **paramètres d'état** — ce qui change le
comportement des gestes. Chaque geste a un identifiant stable (`XX-n`, jamais réattribué), ses
**variantes** selon les paramètres, et son **effet observable** — ce qu'un test constate. La
colonne *Test* cite ce qui le couvre : le test unitaire (un fichier de `test/`, sa méthode) pour la
logique, et l'étape du **parcours** (`test/e2e/parcours_test.dart`, une édition jouée de bout en bout
sur la vraie application) pour le geste ; « recette » quand le geste ne se joue pas en test de widget,
avec la raison *(L18, 2026-09-20)*.

Ce document cite le code ; le code ne le cite pas.

---

## Transversal (toutes les pages)

Paramètres : **événement sélectionné** (oui / non) · **éditeur latéral ouvert** (oui / non), **modifié** (oui / non) ·
**douchette** (branchée ou non — un scan est une frappe clavier terminée par Entrée).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **TR-1** Choisir une page dans le rail de gauche (sept entrées : Événements, Joueurs, Groupes, Sessions, Tirages, Générateur de carte, Guide) | aucun événement en base | la page s'affiche ; l'entrée est marquée. Aucun événement en base → les cinq entrées hors *Événements* et *Guide* sont **grisées**, infobulle « Créez d'abord un événement » ; arriver sur l'une de ces pages **renvoie** à la liste des événements (`EventSelectedGuard`) | `parcours_test.dart` (étape 1) |
| **TR-2** Choisir l'événement courant dans la barre du haut (cinq pages : joueurs, groupes, sessions, tirages, générateur) | événement choisi / aucun | toutes les pages travaillent sur cet événement. Aucun → à l'arrivée sur la page, le sélecteur **s'ouvre de lui-même** ; fermé sans choisir, la page affiche « Veuillez sélectionner un événement » et un bouton **« Choisir un événement »** qui le rouvre (`EventSelectedGuard`). Le choix n'est pas retenu d'un lancement à l'autre | `parcours_test.dart` (étapes 1, 6) |
| **TR-3** Fermer l'éditeur latéral : *Annuler* / *Fermer*, la croix du titre, Échap, un clic hors du tiroir | modifié ou non | rien n'est enregistré. Non modifié → le tiroir se ferme. Modifié (une valeur différente de l'ouverture, ou un badgeage manuel en attente ; une valeur remise ne compte pas) → modale « Modification en cours » : *Revenir* garde l'éditeur et la saisie, *Quitter* ferme ; Échap dans la modale = *Revenir* (`EditorPod.requestClose`, `DirtyAware`) | `forms_dirty_test.dart` ; `parcours_test.dart` (étape 2) |
| **TR-4** Scanner une carte (douchette) sur n'importe quelle page | carte connue / inconnue ; événement sélectionné ou non ; boîte de dialogue ouverte | **le retour est le même partout** : dans la barre du haut, une icône de douchette et le message du dernier scan — vert (fait), rouge (erreur) ; tant que rien n'a été scanné, il dit **ce qu'un scan fait sur cette page** (« Scanner une carte pour ouvrir la fiche joueur », « … pour badger cette session »…) ; il reste jusqu'au scan suivant, d'une page à l'autre, et s'efface quand ce qu'un scan fait change (mode suppression, SE-6 / GR-6) (`ScanStatus`, `scanStatusPod`). Ce que le scan **fait** dépend de la page : par défaut il **ouvre la fiche du joueur** (événements, joueurs, groupes, tirages, générateur) ; la page d'un groupe ajoute au groupe (GR-5), les pages de sessions badgent (SE-2, SE-4). Carte inconnue → **« Carte invalide »** ; sans événement → « Aucun événement sélectionné » ; code vide (frappe parasite) → rien ; boîte de dialogue ouverte → rien (elle a son propre écouteur, ou n'attend pas de carte) | `event_service_test.dart` (`getPlayerByQrCode`) ; `parcours_test.dart` (étapes 2, 4, 5, 7) |
| **TR-5** Recevoir une notification (réglages enregistrés, carte sans protection…) | information / erreur | un **toast en haut au centre** de la fenêtre, 2 s (3 s pour une erreur), une croix pour fermer ; jamais en bas (`Toast`) | `parcours_test.dart` (étapes 3, 4) |
| **TR-6** Ouvrir l'aide de la page : le « i » en haut à droite de la barre (huit pages, toujours en dernier) | données de la page (liste vide, session ouverte, tirage effectué…) | un **pas à pas** sur le vrai écran : voile sombre, trou autour de l'élément visé, bulle avec une ou deux phrases, compteur « n / total », *Suivant* (*Terminer* au dernier), *Passer*, croix, Échap. Les pas suivent les données : une liste vide dit où les choses apparaîtront ; une cible absente est sautée. Pendant le pas à pas, **la douchette ne fait rien** ; elle reprend à la fermeture (`HelpButton`, `HelpTour`). Les petits « i » à infobulle (`HelpHint`) et les légendes dans l'écran complètent, sans geste | `parcours_test.dart` (étape 10) |
| **TR-7** Ouvrir le guide (dernière entrée du rail, *Guide*) | événement en base ou non | la page du guide : en tête, où trouver l'aide (petit « i », légende, « i » de la barre) ; puis le parcours d'une édition en six temps — événement (avec son aperçu de sessions et son fichier de sauvegarde), joueurs, cartes, sessions, groupes, tirages —, chacun avec deux phrases, **le vrai composant de l'écran** avec des valeurs d'exemple (carte de joueur, carte imprimée, carte de session et billes, gagnants, fichier de sauvegarde) et un bouton *Ouvrir la page …*. **Jamais grisée** ; sans événement en base, seuls le guide et *Ouvrir la page Événements* répondent, les autres boutons sont grisés comme le rail (`HelpPage`, `PlayerListCard`, `SessionCard`, `WinnerCard`) | `parcours_test.dart` (étape 1) |

---

## Événements

Paramètres : **événement neuf / existant** · **des joueurs existent** (oui / non) · **protection
des cartes** (allumée / éteinte) · **sessions existantes** (oui / non).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **EV-1** Créer un événement (bouton « + », ou le bloc central « Créer un événement » quand la liste est vide sans recherche) | liste vide / non | l'éditeur s'ouvre, titre *Créer un événement*, champs vides, dates par défaut (maintenant, +1 jour). Liste vide sans mot-clé → le bloc central remplace la liste | `parcours_test.dart` (étapes 1, 6) |
| **EV-2** Ouvrir un événement (clic sur sa ligne) | — | l'éditeur s'ouvre, titre *Modifier un événement*, champs remplis | `parcours_test.dart` (étape 3) |
| **EV-3** Renseigner nom, début, fin, durée de session (min), intervalle de session (min) | champ vide → message « … est requis » à l'enregistrement ; fin avant début ou intervalle nul → « Aucune session » | début et fin sur une ligne, durée et intervalle sur la suivante ; dessous, l'**aperçu des sessions** que ces valeurs donneront, refait à chaque saisie : leur nombre, la première, la deuxième, « … », la dernière (jour et heure) — le même calcul que la génération (`EventService.sessionStarts`) | `event_service_test.dart` (`sessionStarts`) ; `parcours_test.dart` (étape 1) — les dialogues date / heure de Flutter en recette (L18, C8) |
| **EV-4** Allumer *Protéger les cartes contre la copie et la réutilisation* | des joueurs existent → interrupteur **grisé**, texte « Des joueurs existent déjà… » | un code secret (8 caractères) est tiré ; les cartes et joueurs générés ensuite portent `sel-numéro` (`Event.qrCodeFor`) | service (`qrCodeFor`, `saltFromCode`) ; `parcours_test.dart` (étapes 1, 3) |
| **EV-5** Éteindre la protection | idem grisé si joueurs | le sel est vidé ; les codes redeviennent le numéro seul | `parcours_test.dart` (étape 3) |
| **EV-6** *Récupérer la protection depuis une carte imprimée* | visible seulement **sans joueur** ; carte protégée / non protégée | boîte « Scannez une carte… » ; carte protégée → interrupteur allumé avec son sel ; non protégée → message « Cette carte n'a pas de protection » | service (`saltFromCode`) ; `parcours_test.dart` (étape 3) |
| **EV-7** *Supprimer les joueurs* | visible seulement **avec joueurs** ; confirmer / annuler | confirmation avec le nombre ; confirmé → plus aucun joueur, badgeages et gagnants perdus, protection déverrouillée | `event_service_test.dart` (`destroyPlayers`) ; `parcours_test.dart` (étapes 3, 9) |
| **EV-8** Les sessions suivent les paramètres — *Enregistrer* avec début, fin, durée ou intervalle changés (pas de coche, L19) | neuf / existant ; paramètres changés ou non ; **des badgeages existent** ou non | neuf → les sessions sont générées d'office, de début à fin, une toutes les *intervalle* minutes, longues de *durée* ; existant, paramètres inchangés → les sessions restent ; changés sans badgeage → recréées **sans demander** ; changés avec badgeages → modale « Recréer les sessions ? — Les horaires ont changé : … n badgeages perdus » : *Recréer les sessions* recrée, les badgeages sont perdus ; *Annuler les modifications* remet les quatre champs à leur valeur enregistrée, l'éditeur reste ouvert, rien n'est écrit | `event_service_test.dart` (`save`, `countBadges`) ; `forms_dirty_test.dart` (`eventSessionsChanged`) ; `parcours_test.dart` (étapes 1, 3, 8) |
| **EV-9** *Enregistrer* | neuf / existant ; paramètres de session changés ou non (EV-8) | l'événement apparaît ou se met à jour dans la liste ; le tiroir se ferme | `parcours_test.dart` (étapes 1, 3, 8) |
| **EV-10** *Fermer l'événement* (l'icône de sortie au bout de sa ligne dans la liste, ou le bouton en bas à gauche de son éditeur) | fichier de sauvegarde à jour / absent ou en échec d'écriture ; *Annuler* | **toujours une modale** (L21). Avec un fichier, réécrit d'abord : « Fermer « X » ? Son fichier de sauvegarde reste : … » — *Fermer* ; sans fichier, ou écriture en échec : « Cet événement n'est pas sauvegardé » — *Fermer quand même* (rouge). Confirmé → l'événement et **tout ce qui s'y rattache** (joueurs, sessions et badgeages, groupes, tirages, gagnants) sont supprimés en une transaction (`EventService.destroyEvent`), l'éditeur se ferme, plus d'événement sélectionné, toast « Événement « X » fermé » (avec le chemin du fichier s'il y en a un). Le fichier de sauvegarde n'est **jamais** supprimé : l'ouvrir (EV-13) ramène l'événement. *Annuler* → rien | `event_service_test.dart` (`destroyEvent`) ; `parcours_test.dart` (étape 11 : sans fichier puis avec, depuis l'éditeur puis depuis la liste) |
| **EV-11** *Annuler* (ou TR-3) | modifié ou non — compte : nom, dates, durée, intervalle, protection (EV-4) | rien n'est enregistré ; modifié → modale de TR-3 d'abord | `forms_dirty_test.dart` (`eventFormIsDirty`) ; `parcours_test.dart` (étape 8) |
| **EV-12** Choisir le fichier de sauvegarde (*Choisir…* dans le bloc *Fichier de sauvegarde* de l'éditeur ; *Retirer*) | événement neuf / existant ; dossier disparu au lancement | le dialogue du système demande où écrire (nom proposé `<nom>.marathon.json`) et écrit la première version ; le chemin s'affiche, avec « Dernière sauvegarde à HH:MM:SS » ; existant → chemin enregistré tout de suite, neuf → avec *Enregistrer*. Ensuite **toute modification en base** (joueurs, badgeages, groupes, tirages, image) réécrit le fichier, 2 s après la dernière et au plus 30 s après la première ; écriture atomique ; la fermeture de l'application attend l'écriture. *Retirer* → « Aucun fichier », plus d'écriture. Dossier disparu au lancement → chemin retiré, toast « … choisissez-en un nouveau » ; écriture impossible → toast « Sauvegarde impossible pour … ». Le chemin est propre au poste : **il ne voyage pas** dans le fichier (`Event.backupPath`, `BackupService`, `BackupFormat`) | `backup_service_test.dart` (format, écriture automatique) ; `parcours_test.dart` (étape 11) — le dialogue du système en recette |
| **EV-13** *Ouvrir un fichier de sauvegarde* (bouton à côté de la recherche, liste des événements) | événement du fichier absent / déjà en base (même `uid`) ; fichier illisible | absent → l'événement est **ajouté** avec tout ce qu'il contient (joueurs, sessions et badgeages, groupes, tirages et gagnants, image), devient l'événement sélectionné, toast « Événement « … » ajouté » ; déjà là → modale « Cet événement est déjà là » : *Remplacer* (l'événement en base et tout ce qui s'y rattache sont recréés depuis le fichier, en une transaction, son chemin de sauvegarde gardé) ou *Annuler* ; illisible (pas du JSON, version inconnue, champ manquant) → toast « Ce fichier n'est pas un fichier de sauvegarde lisible », rien n'est écrit (`BackupService.open` / `import`) Les tirages gardent leur **numéro** et leur nom (L21). | `backup_service_test.dart` (aller-retour, remplacement) ; `parcours_test.dart` (étape 11) — le dialogue du système en recette |

---

## Joueurs

Paramètres : **joueurs existants** (n) · **bonus** du joueur (0 / > 0) · **éditeur ouvert sur le
même joueur** (oui / non) · **protection** (allumée / éteinte).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **JO-1** Saisir un *Nombre de joueurs* puis *Générer les joueurs manquants* | nombre ≤ existants → champ en erreur « Déjà n joueurs existants », bouton grisé ; > → complète | des joueurs numérotés de n+1 à N apparaissent, code `sel-numéro` ou numéro seul ; le champ reprend le nouveau nombre | `event_service_test.dart` (`generateMissingPlayers`) ; `parcours_test.dart` (étapes 2, 3, 9) |
| **JO-2** « + » sur la ligne *Bonus* d'une carte | — | bonus +1 et *jetons* +1 tout de suite ; enregistré 400 ms après le dernier clic, ou en quittant la page ; fermer la fenêtre pendant la pause **retient la fermeture** le temps d'écrire, sans rien demander (`AppLifecycleListener.onExitRequested`) | `parcours_test.dart` (étape 2) — la fermeture de la fenêtre en recette (pas de fenêtre en test de widget) |
| **JO-3** « − » sur la ligne *Bonus* | bonus 0 → bouton **désactivé** | bonus −1, jetons −1 | `parcours_test.dart` (étape 2) |
| **JO-4** Ouvrir la fiche d'un joueur (clic sur la carte, hors boutons) | — | tiroir *Modifier un joueur* : image du code, numéro, nom, bonus, sessions | `parcours_test.dart` (étape 2) |
| **JO-5** Scanner une carte | connue / inconnue | connue → la fiche du joueur s'ouvre, **sans badger**, barre « Joueur n : fiche ouverte » ; inconnue → TR-4 | `parcours_test.dart` (étape 2) |
| **JO-6** Lire une carte : bille du **numéro**, billes *sessions*, *bonus*, *jetons* | valeur 0 → bille **grisée** ; sans jeton, la bille du numéro aussi | jetons = sessions badgées + bonus ; cartes de taille fixe (200 × 176) rangées en lignes ; une **légende** en bas de page dit ce que sont les jetons et la bille grise | `parcours_test.dart` (étape 2) |

### Fiche joueur (éditeur latéral)

Paramètres : **badgeage manuel** (éteint / allumé) · session **badgée / non badgée** ·
session **passée / à venir**.

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **JO-7** Modifier le nom | vide → « Le nom est requis » | — | `parcours_test.dart` (étape 2) |
| **JO-8** « − » / « + » / saisie du bonus | « − » désactivé à 0 ; saisie non numérique refusée | valeur du champ ; **rien en base avant *Enregistrer*** | `parcours_test.dart` (étape 2) |
| **JO-9** Allumer *Badgeage manuel* | — | les cartes de session deviennent cliquables (curseur main) | `parcours_test.dart` (étape 2) |
| **JO-10** Cliquer une session en badgeage manuel | badgée → devient absente ; absente → devient présente ; badgeage manuel éteint → rien | bille verte / grise dans la fiche ; **rien en base avant *Enregistrer*** | `event_service_test.dart` (`setPlayerSessions`) ; `parcours_test.dart` (étape 2) |
| **JO-11** *Enregistrer* | avec / sans badgeages en attente | nom, bonus, badgeages écrits en une fois ; la carte du joueur et la page session le reflètent ; tiroir fermé | `event_service_test.dart` (`setPlayerSessions`) ; `parcours_test.dart` (étape 2) |
| **JO-12** *Annuler* (ou TR-3) | modifié ou non — compte : nom, bonus, badgeages manuels en attente | rien n'a changé, badgeages en attente jetés ; modifié → modale de TR-3 d'abord | `forms_dirty_test.dart` (`playerFormIsDirty`) ; `parcours_test.dart` (étape 2) |
| **JO-13** Lire la fiche : légende présent / absent / badgeage manuel ; aide du bonus | session passée → carte grise | — | `parcours_test.dart` (étape 2) |

---

## Groupes

Paramètres : **groupes existants** (n, manuels ou de gagnants) · **joueurs dans le groupe** (n) ·
**tirages qui utilisent le groupe** (0 / n).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **GR-1** Créer un groupe (bouton « + », événement sélectionné) | — | tiroir *Créer un groupe de joueurs* : un nom | `parcours_test.dart` (étape 5) |
| **GR-2** Nommer, *Enregistrer* | nom vide → message requis | le groupe apparaît dans la liste, vide | `parcours_test.dart` (étape 5) |
| **GR-3** Ouvrir un groupe (clic sur sa ligne) | — | la page du groupe : titre « Membres (n) », billes des joueurs membres, triées par numéro ; bouton retour ; crayon → l'éditeur (GR-11) | `parcours_test.dart` (étape 5) |
| **GR-4** Scanner une carte sur la liste des groupes | — | la fiche du joueur s'ouvre (le défaut, TR-4) | `parcours_test.dart` (étape 5) |
| **GR-5** Scanner une carte sur la page d'un groupe | déjà membre / pas encore | le joueur rejoint le groupe, barre « Joueur n ajouté au groupe » ; déjà membre → inchangé, « Joueur n déjà dans le groupe » (information, pas une erreur) | `player_group_service_test.dart` (`addPlayer`) ; `parcours_test.dart` (étape 5) |
| **GR-6** Retirer un joueur d'un groupe (interrupteur *Mode suppression*, puis *Retirer* sur sa bille, **ou scanner sa carte**) | mode allumé (rouge) / éteint ; membre / non membre | allumé : chaque bille devient une carte bille + *Retirer* ; *Retirer* enlève le joueur tout de suite ; le retour de scan (TR-4) passe sur fond « erreur » et **clignote** au passage : « Scanner une carte pour retirer le joueur du groupe » ; scan d'un membre → retiré, « Joueur n retiré du groupe » ; non membre → « Joueur n n'est pas dans le groupe » ; éteint : billes seules, retour de scan normal | `player_group_service_test.dart` (`removePlayer`) ; `parcours_test.dart` (étape 5) |
| **GR-7** Supprimer un groupe (poubelle sur sa ligne dans la liste, ou *Supprimer* dans son éditeur ; confirmer) | manuel sans tirage / manuel utilisé par n tirages / de gagnants | manuel libre : confirmation, puis le groupe disparaît, ses joueurs restent ; utilisé par un tirage (exclu ou requis, préparé ou effectué) : liste → modale « Utilisé par n tirages », éditeur → *Supprimer* grisé avec la même raison ; de gagnants : pas de *Supprimer*, nom en lecture seule | `player_group_service_test.dart` (`countUsingGroup`) ; `parcours_test.dart` (étapes 5, 7) |
| **GR-8** Les groupes « Gagnants du tirage « … » » | créés par un tirage lancé (TI-8) | **absents de la liste des groupes** (une ligne d'aide le dit) ; visibles dans leur tirage (ses gagnants) et dans le sélecteur des tirages, marqués d'un trophée (TI-4) ; les groupes d'avant la catégorie sont reclassés à l'ouverture de la base | `player_group_service_test.dart` (migration), `draw_service_test.dart` (`kind`) ; `parcours_test.dart` (étape 7) |
| **GR-9** *Annuler* (ou TR-3) dans l'éditeur d'un groupe | modifié ou non — compte : le nom | rien n'est enregistré ; modifié → modale de TR-3 d'abord | `forms_dirty_test.dart` (`playerGroupFormIsDirty`) ; `parcours_test.dart` (étape 5) |
| **GR-10** Ajouter un joueur par son numéro (champ *Ajouter par numéro*, Entrée ou *Ajouter*) | numéro connu / inconnu / déjà membre | connu : le joueur rejoint le groupe, le champ se vide ; inconnu : « Numéro n inconnu » en rouge ; déjà membre : « Numéro n déjà dans le groupe » ; chaque cas est aussi dit en **toast** (TR-5), même texte qu'un scan ; deux secondes sans saisie rendent la main à la douchette | `player_group_service_test.dart` (`addPlayer`) ; `parcours_test.dart` (étape 5) |
| **GR-11** Modifier un groupe (crayon sur sa ligne dans la liste, ou dans la barre de sa page) | manuel / de gagnants | tiroir *Modifier un groupe de joueurs* : le nom, *Enregistrer* ; de gagnants → nom en lecture seule, ligne d'aide « il porte le nom du tirage et ne se supprime pas » ; supprimer depuis la page (GR-7) ramène à la liste | `parcours_test.dart` (étape 5) |

---

## Sessions

Paramètres : **heure courante** vs session (à venir / **ouverte** / passée) · **badgeage
manuel** (éteint / allumé) · joueur **déjà badgé** ou non.

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **SE-1** Lire la liste : cartes numéro, début, fin, « n présents » ; horloge ; légende des couleurs | ouverte → couleur primaire ; passée → grise ; à venir → blanche | — | `session_test.dart` (`isOpenAt`) ; `parcours_test.dart` (étape 6) |
| **SE-2** Scanner une carte sur la liste des sessions | une session ouverte / aucune ; déjà badgé | ouverte → le joueur y est badgé, barre « Joueur n badgé sur la session k » ; aucune session ouverte → rien, erreur **« Aucune session ouverte »** ; déjà badgé → rien, « Joueur n déjà présent sur la session k » (information). Bloquer sur l'horaire du poste est voulu : le badgeage manuel (SE-5) est le geste qui ouvre une session à la main | `event_service_test.dart` (`badgeOpenSession`) ; `parcours_test.dart` (étapes 6, 9) |
| **SE-3** Ouvrir une session (clic sur sa carte) | — | la page de la session : en-tête « Session n — début à fin — Ouverte / Passée » (rien pour une session à venir) à gauche, horloge à droite ; interrupteur *Badgeage manuel*, champ *Numéro* + bouton *Ajouter* (badger sans carte), interrupteur *Mode suppression* ; deux zones de billes (numéro) : **Présents** (vert) puis **Absents** (gris, ont badgé une autre session) ; les joueurs jamais badgés n'apparaissent pas ; bouton retour | `parcours_test.dart` (étape 6) |
| **SE-4** Scanner une carte sur la page d'une session, badgeage manuel **éteint** | session ouverte / non ouverte ; déjà badgé | ouverte → badgé sur **cette** session, barre « Joueur n badgé sur la session k » ; non ouverte → rien, erreur **« La session n'est pas ouverte »** ; déjà badgé → « déjà présent » (information) | `event_service_test.dart` (`badgeSession`) ; `parcours_test.dart` (étape 6) |
| **SE-5** Allumer l'interrupteur *Badgeage manuel* puis scanner | session ouverte ou non ; déjà badgé | badgé sur **cette** session quelle que soit l'heure, même message que SE-4 ; déjà badgé → « déjà présent » | `event_service_test.dart` (`badgeSession`, `manual`) ; `parcours_test.dart` (étape 6) |
| **SE-6** Dé-badger un joueur depuis la page d'une session (*Retirer* sur sa bille, **ou scanner sa carte**) | *Mode suppression* allumé ; présent / absent | chaque bille présente devient une carte bille + *Retirer* ; *Retirer* → le joueur passe dans Absents (ou disparaît s'il n'a badgé nulle part ailleurs), écrit tout de suite, sans confirmation ; le retour de scan (TR-4) passe sur fond « erreur » et **clignote** au passage : « Scanner une carte pour retirer le joueur de cette session » ; scan d'un présent → retiré, « Joueur n retiré de la session k » ; absent → « Joueur n n'est pas sur la session k » ; éteindre → billes, retour de scan normal | `event_service_test.dart` (`removePlayerFromSession`) ; `parcours_test.dart` (étapes 6, 9) |
| **SE-7** Générer / supprimer les sessions | — | *(non proposé sur cette page : voir EV-8)* | `parcours_test.dart` (étape 6 : rien de tel sur la page) |
| **SE-8** Taper un numéro dans *Numéro* puis *Ajouter* (ou Entrée) — badger sans carte | session ouverte ou badgeage manuel allumé / ni l'un ni l'autre ; numéro inconnu | le joueur est badgé sur **cette** session (SE-9 pour l'animation), le champ se vide, **toast** « Joueur n badgé sur la session k » (TR-5) ; déjà présent → toast « déjà présent » ; champ et bouton grisés hors session ouverte, badgeage manuel ou mode suppression ; inconnu → « Numéro n inconnu », aussi en toast. Le champ rend le focus à la douchette : à Entrée, après 2 s sans saisie, ou dès qu'un code de douchette s'y tape (le champ se vide, le scan fait son effet normal) | `event_service_test.dart` (`badgeSession`) ; `parcours_test.dart` (étape 6) |
| **SE-9** Badgeage réussi sur la page d'une session (SE-4, SE-5, SE-8) | le joueur était dans Absents / jamais badgé | dans Absents : sa bille rétrécit et disparaît, puis grossit dans Présents ; jamais badgé : elle grossit dans Présents ; le compte de la zone suit | `parcours_test.dart` (étape 6 : le compte des zones ; l'animation en recette) |
| **SE-10** En *Mode suppression* (interrupteur et libellé en rouge), le bouton devient *Supprimer* (rouge, poubelle) ; *Supprimer* (ou Entrée) avec un numéro | présent / absent ; inconnu | le joueur est retiré de cette session, le champ se vide, toast « Joueur n retiré de la session k » ; absent → rien, toast « n'est pas sur la session » ; inconnu → « Numéro n inconnu », aussi en toast | `event_service_test.dart` (`unbadgeSession`) ; `parcours_test.dart` (étape 6) |

---

## Tirages

Paramètres : tirage **neuf / préparé / effectué** · **joueurs éligibles** (0 / n) · **jetons dans
l'urne** (0 / n) · **groupes existants** · **gagnants** du tirage (0 / n).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **TI-1** Créer un tirage (bouton « + ») | — | tiroir *Créer un tirage* : nom « Tirage N°n » où n est le **numéro du tirage dans l'événement** (le plus grand + 1 ; jamais l'identifiant de base, L21), 1 gagnant, min 1 session, **dernière session requise** | `draw_service_test.dart` (`createDraw`) ; `parcours_test.dart` (étape 7) |
| **TI-2** Ouvrir un tirage (clic sur sa ligne) | la bille de la ligne porte le **numéro** du tirage (L21) ; préparé → *Modifier un tirage* ; effectué → *Consulter un tirage*, champs grisés, sélecteurs ouvrables mais figés | les choix enregistrés sont retrouvés (groupes, sessions, min / max, gagnants) | `parcours_test.dart` (étapes 7, 9) |
| **TI-3** Régler nom, nombre de gagnants, min / max de sessions | valeurs non numériques refusées | les compteurs *joueurs* et *jetons* se recalculent | `draw_service_test.dart` (`getEligibilityFor`) ; `parcours_test.dart` (étape 7) |
| **TI-4** Choisir des groupes exclus / requis | groupes résolus **au lancement**, pas à la préparation ; les groupes de gagnants portent un trophée | compteurs recalculés ; requis vide = tous | `draw_service_test.dart` ; `parcours_test.dart` (étape 7) |
| **TI-5** Choisir des sessions exclues / requises (grille, recherche par numéro) | — | compteurs recalculés | `draw_service_test.dart` ; `parcours_test.dart` (étape 7) |
| **TI-6** Lire les compteurs : *n joueurs sélectionnés*, *m jetons dans l'urne* | joueur sans jeton → hors compte | jetons = somme des jetons des éligibles | `draw_service_test.dart` ; `parcours_test.dart` (étape 7) |
| **TI-7** *Enregistrer* | neuf / préparé | le tirage est dans la liste, **préparé**, sans gagnant ; rien n'est tiré | `draw_service_test.dart` (`save`) ; `parcours_test.dart` (étape 7) |
| **TI-8** *Tirer au sort* | confirmation (gagnants, joueurs) ; 0 éligible ; tirage déjà effectué (refusé par le service) | gagnants désignés par poids (jetons), affichés N°1, N°2… ; **date posée** ; groupe *Gagnants du tirage « … »* créé ; le tirage passe en lecture seule ; 0 éligible → effectué sans gagnant, sans groupe | `draw_service_test.dart` (`calculateDraw`, `getWinner`) ; `parcours_test.dart` (étape 7) |
| **TI-9** *Copier* (icône dans la liste, ou bouton d'un tirage consulté) | source préparée / effectuée | tiroir *Créer un tirage* sur une copie **non enregistrée** : mêmes réglages, nom « Tirage N°n » (numéro suivant de l'événement, L21), et le groupe des gagnants de la source parmi les groupes exclus (si effectuée) | `draw_service_test.dart` (`createDrawFromDraw`) ; `parcours_test.dart` (étape 7) |
| **TI-10** Cliquer un gagnant | — | la fiche du joueur s'ouvre | `parcours_test.dart` (étape 7) |
| **TI-11** Rechercher un tirage | — | *(non proposé — retiré le 2026-09-20 : le champ ne filtrait pas)* | `parcours_test.dart` (étape 7 : le champ est absent) |
| **TI-12** Supprimer un tirage | — | *(non proposé — acté 2026-09-19, L06)* | `parcours_test.dart` (étape 7 : le bouton est absent) |
| **TI-13** *Annuler* / *Fermer* (ou TR-3) | préparé : compte nom, gagnants, min / max, groupes et sessions choisis ; neuf avec ses défauts → non modifié ; effectué → jamais modifié | rien n'est enregistré ; modifié → modale de TR-3 d'abord | `forms_dirty_test.dart` (`drawFormIsDirty`) ; `parcours_test.dart` (étape 7) |

---

## Générateur de carte

Paramètres : **image de fond** (absente / présente) · **réglages enregistrés** (oui / non) ·
**protection** (allumée / éteinte) · **aperçu** (rapide / PDF).

| Geste | Variantes | Effet observable | Test |
|---|---|---|---|
| **CA-1** Choisir une image de fond (clic sur le cadre) | image absente → « Choisissez une image de fond pour voir l'aperçu » | l'aperçu rapide apparaît ; la hauteur de carte suit le ratio de l'image | recette — dialogue du système ; le parcours pose l'image en base (étape 4) |
| **CA-2** Régler la planche : cartes par ligne, lignes par page, portrait / paysage, largeur de carte (mm), marge de page, espaces, couleur de fond de page | décimales avec virgule ou point ; valeur non numérique ignorée | l'aperçu rapide suit chaque frappe ; hauteur affichée « Hauteur : x mm, selon l'image » | `card_layout_test.dart` ; `parcours_test.dart` (étape 4) |
| **CA-3** Régler le QR code : taille, position X / Y, fond optionnel (case + couleur), marge du fond | — | idem | `parcours_test.dart` (étape 4) |
| **CA-4** Régler le numéro : position, taille de police, couleur, fond optionnel, marge | — | idem | `parcours_test.dart` (étape 4) |
| **CA-5** Choisir la plage *Du numéro* / *Au numéro* | fin < début → une carte ; plage non multiple → **complétée** ; *Au numéro* **> nombre de joueurs** | ligne « n cartes, du numéro a au numéro b, sur p pages » ; sous la plage, « n joueurs » et, au-delà des joueurs, un bouton **« Générer les joueurs supplémentaires »** qui crée les joueurs jusqu'à *Au numéro* (JO-1) — la ligne suit, le bouton disparaît, leurs cartes se scannent (TR-4) | `card_layout_test.dart`, `event_service_test.dart` (`generateMissingPlayers`) ; `parcours_test.dart` (étape 4) |
| **CA-6** Basculer *Aperçu rapide* / *Aperçu PDF* | — | rapide : première page, immédiat ; PDF : toutes les pages, telles qu'imprimées, imprimable | `parcours_test.dart` (étape 4 : la bascule) — le rendu PDF en recette (module natif d'impression, absent en test) |
| **CA-7** *Enregistrer* | — | réglages et image (réduite à 300 dpi de la largeur de carte) écrits sur l'événement ; toast « Réglages enregistrés » (TR-5) ; retrouvés au redémarrage | service (`CardSettings`) ; `parcours_test.dart` (étape 4) |
| **CA-8** Lire le code d'une carte imprimée à la douchette | protection allumée / éteinte | le joueur de ce numéro est reconnu (JO-5, SE-2…) — protection allumée : seulement si le sel est celui de l'événement | service (`qrCodeFor`) ; `parcours_test.dart` (étape 2) |
| **CA-9** Imprimer | depuis l'aperçu PDF | dialogue d'impression du système | recette — dialogue du système |

---

## Ce que ce relevé montre (2026-09-19)

Gestes **sans effet ou absents** aujourd'hui, à trancher lot par lot : SE-7 *(GR-4, GR-6, GR-7 et
TI-11 tranchés le 2026-09-20 ; EV-10 fait par L21)*. Chaque geste a son test depuis L18 (2026-09-20) : le
parcours joue les 76, sauf cinq dialogues du système et une animation, en recette.
L'icône de l'application et les noms que Windows affiche pour le programme (L20) ne sont pas des
gestes : ils se constatent à la recette, dans l'Explorateur et la barre des tâches.

