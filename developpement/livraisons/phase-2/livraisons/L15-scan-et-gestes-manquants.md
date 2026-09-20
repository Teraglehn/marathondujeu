# L15 — Retour de scan sur toutes les pages, et gestes manquants

Statut : **livré** le 2026-09-20 (ouvert le 2026-09-19, questions tranchées le 2026-09-19,
recette le 2026-09-20) · Ne dépend
d'aucun lot. Issu du relevé `docs/gestes.md` (2026-09-19) ; les arbitrages sont de Bastien, le
même jour.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Le relevé des gestes montre des scans silencieux ou trompeurs, et quelques gestes sans effet ou
absents. Ce lot **rend chaque scan lisible** — le même retour, au même endroit, sur toutes les
pages — et règle les gestes relevés qui ne relèvent ni des groupes (L16), ni des sessions
(L13), ni des modifications en cours (L17).

### Terminologie

- **Scanner** : passer une carte sous la douchette. Ce que le scan **fait** dépend de la page ;
  ce qu'il **annonce** est le même partout (C1).
- **Fiche joueur** : le tiroir *Modifier un joueur*.
- **Session ouverte** : celle dont l'horaire encadre l'heure du poste. **Bloquer le badgeage sur
  l'horaire du poste est voulu** ; le badgeage manuel est le geste qui « ouvre une session à la
  main » *(Bastien, 2026-09-19)*.

## Périmètre

| Cible | Détail |
|---|---|
| **Retour de scan** (toutes les pages) | dans la barre du haut, une **icône de douchette** et le **message du dernier scan** : ce qui a été fait, ou l'erreur (C1). Remplace les notifications « Joueur n a été scanné » |
| **Toutes les notifications** | passent en **toast centré en haut** de la fenêtre (règle actée 2026-09-19, `CLAUDE.md`) : un widget `Toast` posé dans l'`Overlay`, durée courte, croix pour fermer ; les cinq `SnackBar` actuels disparaissent (C8) |
| **Ce que fait un scan, page par page** (C2) | *Événements, Joueurs, Groupes (liste), Générateur* : ouvre la **fiche joueur** — c'est le **défaut**. *Page d'un groupe* : ajoute au groupe. *Sessions (liste)* : badge la session ouverte ; aucune ouverte → erreur **« Aucune session ouverte »**. *Page d'une session* : session ouverte → badge cette session ; badgeage manuel allumé → badge cette session ; sinon → erreur **« La session n'est pas ouverte »**. *Tirages* : fiche joueur (défaut) |
| **Carte invalide** | carte inconnue de l'événement (numéro sans joueur, autre édition) → erreur **« Carte invalide »**, sur toutes les pages (C3) |
| **Déjà badgé** | scan d'un joueur déjà présent sur la session visée → message « Déjà présent », pas une erreur (C4) |
| Tirages | le champ *Recherche* disparaît (TI-11) |
| Joueurs — *Générer les joueurs manquants* | nombre saisi ≤ joueurs existants → champ en erreur, bouton bloqué, message **« Déjà n joueurs existants »** (JO-1) |
| Générateur — cartes au-delà des joueurs | *Au numéro* > nombre de joueurs → un bouton **« Générer les joueurs supplémentaires »** (jusqu'à ce numéro), à côté de la plage (C5) |
| Événement — *Générer les sessions* | des badgeages existent → **confirmation** avant d'enregistrer : « Les sessions seront recréées et n badgeages perdus » (EV-8) |
| Joueurs — bonus en attente | fermer l'application pendant les 400 ms **retient la fermeture** le temps d'écrire, sans rien demander (C6) |
| Textes | messages de scan, erreurs, bouton, confirmation — fr/en ; les clés `page_sessionList_generateSessions` / `deleteSessions`, jamais affichées, sont retirées (SE-7) |
| `docs/gestes.md` | TR-4, GR-4, SE-2, SE-4, JO-1, JO-5, TI-11, CA-5, EV-8 mis à jour **dans le même commit** |

### Hors périmètre

- **Groupes** (catégories, suppression, retrait d'un joueur, ajout par numéro) : L16.
- **Page d'une session** (dé-badger, cartes, affichage) : L13, **livré le 2026-09-19**. À
  reprendre ici : la page utilise encore un `SnackBar` au scan ; son champ *Numéro* rend le
  focus à la douchette (Entrée, 2 s, code de douchette tapé) — L13 C10 — à vérifier avec le
  retour de scan.
- **Modifications en cours** à la fermeture d'un éditeur : L17.
- **Nom du joueur** : laissé tel quel, volontairement *(Bastien, 2026-09-19)*.
- **Changer d'événement pendant qu'un éditeur est ouvert** (TR-2) : impossible aujourd'hui — le
  tiroir est celui du `Scaffold` extérieur, son voile couvre le rail et la barre de la page
  (vérifié dans `desktop.layout.dart`). Rien à faire.
- **Session requise d'une copie de tirage** (TI-9) : la copie reprend les paramètres de sa
  source et ajoute seulement le groupe des gagnants — c'est déjà ce que fait `createDrawFromDraw`
  (L06, testé). Rien à faire.

## Critère de fin

1. Sur chaque page, scanner une carte connue produit un message dans la barre du haut qui dit ce
   qui s'est passé ; une carte inconnue produit « Carte invalide » — sur les huit pages.
2. Liste des sessions : hors de tout créneau, un scan donne « Aucune session ouverte » et ne
   badge rien. Page d'une session non ouverte : « La session n'est pas ouverte » ; badgeage
   manuel allumé : le joueur est badgé sur cette session, message « n badgé sur la session k ».
3. Liste des joueurs : 200 joueurs existent ; saisir 150 → champ rouge, bouton gris, « Déjà 200
   joueurs existants » ; saisir 250 → 50 joueurs créés.
4. Générateur : joueurs 1 à 200, plage 1 à 240 → le bouton « Générer les joueurs
   supplémentaires » crée 201 à 240 ; scanner la carte 230 ouvre sa fiche.
5. Formulaire d'événement, case *Générer les sessions* cochée, des badgeages en base →
   confirmation ; *Annuler* laisse tout en place.
6. Cliquer « + » sur un bonus puis fermer la fenêtre dans la seconde : au redémarrage, le bonus
   est là.
7. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — tout est tranché (voir plus bas).

## Choix d'implémentation

- **C1 — Un seul retour de scan, dans la barre du haut** : un widget `ScanStatus` (icône
  douchette + dernier message, vert pour un succès, rouge pour une erreur, gris quand rien
  n'a été scanné), alimenté par un pod `scanStatus` que `PlayerSessionScanner` renseigne. Le
  message reste jusqu'au scan suivant. Les `SnackBar` « Joueur n a été scanné » disparaissent.
- **C2 — Le défaut d'un scan est « ouvrir la fiche »** ; seules la page d'un groupe et les deux
  pages de sessions font autre chose. `PlayerSessionScanner` reçoit un `mode` explicite
  (`openPlayer`, `addToGroup`, `badgeOpenSession`, `badgeThisSession`) plutôt que la combinaison
  actuelle de `onScanned` / `useSelectedSession` / `forceSelectedSession`.
- **C3 — « Carte invalide » vient du service** : `EventService.getPlayerByQrCode` rend `null` →
  le scanner pose l'erreur. Un code vide (frappe parasite) est ignoré sans message.
- **C4 — « Déjà présent » n'est pas une erreur** : information, pas rouge — l'organisateur a
  juste scanné deux fois.
- **C5 — « Générer les joueurs supplémentaires »** appelle `generateMissingPlayers(event, y)`
  existant ; visible seulement quand *Au numéro* dépasse le nombre de joueurs ; après, la
  ligne de résumé le dit (« 240 joueurs »).
- **C6 — Retenir la fermeture pour écrire le bonus** : `AppLifecycleListener.onExitRequested`
  rend `AppExitResponse.cancel`, écrit les bonus en attente, puis appelle
  `ServicesBinding.instance.exitApplication`. Fonctionne sur Windows (fermeture par la croix de
  la fenêtre). À constater ; si la plateforme ne le permet pas, repli : écrire à chaque clic
  sans regrouper, et le rapport le dit.
- **C7 — Tests** : le service de scan (`EventService`) reçoit les cas — session ouverte / non,
  manuel, déjà présent, carte invalide, aucune session ouverte — sur base Isar ; le retour
  visuel se constate à la recette.
- **C8 — Un seul point pour notifier** : `Toast.show(context, message, {error})`, en haut au
  centre, 2 s (3 s pour une erreur), croix. Remplace `ScaffoldMessenger.showSnackBar` partout ;
  le retour de scan (C1) reste dans la barre, il est persistant, pas une notification.
- **C9 — Sans événement sélectionné, le scan le dit** : erreur « Aucun événement sélectionné »
  — le cas n'existe que sur la page des événements, la seule sans garde ; un scan muet y
  contredirait le critère 1. *(Tranché à l'implémentation, 2026-09-20.)*
- **C10 — Une boîte de dialogue ouverte suspend l'écouteur de la page** : la boîte « Scannez une
  carte » de l'événement a le sien ; sans cela le même scan y posait aussi « Carte invalide »
  dans la barre. Le tiroir latéral n'est pas une boîte : le scan y reste actif (ouvrir une
  autre fiche). *(2026-09-20.)*
- **C11 — Le champ *Nombre de joueurs* ne se remplit plus à chaque rendu** : il reprenait le
  nombre existant à chaque `setState`, ce qui effaçait la saisie dès que le champ passait en
  erreur. Il se remplit quand le nombre de joueurs change. *(2026-09-20.)*
- **C12 — `scaffoldMessengerKey` et `message_player_scanned` retirés** avec les `SnackBar`
  qu'ils servaient. *(2026-09-20.)*

## Constats (2026-09-20)

- Critère 7 : `flutter analyze` sans issue, 69 tests verts (10 nouveaux sur `EventService` :
  `getPlayerByQrCode`, `badgeOpenSession`, `badgeSession`, `countBadges`), `flutter build
  windows` passe.
- Critères 1 à 6 : à la recette. Recette du 2026-09-20 : au repos, la barre disait « Aucune
  carte scannée », grisé — remplacé par ce que le scan fait sur la page (« Scanner une carte
  pour ouvrir la fiche joueur », « … pour ajouter le joueur au groupe », « … pour badger la
  session ouverte / cette session »), en `onPrimary`, zone élargie à 640 px (Bastien).
- Recette du 2026-09-20, **ajout au périmètre** (Bastien) : en **mode suppression** (page d'une
  session, page d'un groupe), **scanner retire** le joueur ; le retour de scan passe sur fond
  `errorContainer` arrondi, texte `onErrorContainer`, et **clignote** 1,5 s au passage ; le
  message d'attente devient « Scanner une carte pour retirer le joueur … ». Le dernier résultat
  s'efface quand le mode change. SE-6 et GR-6 mis à jour.
- Recette du 2026-09-20, **ajout** (Bastien) : le champ *Numéro* (SE-8, SE-10, GR-10) dit son
  résultat en **toast**, même texte qu'un scan (`scanResultText`) ; le dé-badgeage passe par le
  service (`unbadgeSession`, testé) ; `forceAddPlayerToSession` retiré, sans appelant.
- C6 : à constater à la recette — fermer la fenêtre dans la seconde qui suit un « + ».
- Constat hors périmètre, non corrigé : le champ *Nombre de joueurs* vide affiche « La durée de
  session est requise » (mauvaise clé, d'origine).
- Constat hors périmètre : scanner une carte alors qu'un éditeur **modifié** est ouvert remplace
  l'éditeur sans passer par « Quitter / Revenir » (L17 ne couvre que la fermeture).

## Questions tranchées

*(Tous les arbitrages ci-dessous : Bastien, 2026-09-19, sur le relevé `docs/gestes.md`.)*

- **GR-4** — scanner sur la liste des groupes → ouvre la fiche joueur : c'est le défaut de
  toute page qui n'a pas d'usage propre du scan.
- **SE-4 / SE-2** — liste des sessions : badge la session ouverte, sinon « Aucune session
  ouverte » ; page d'une session : badge si ouverte ou en badgeage manuel, sinon « La session
  n'est pas ouverte ».
- **TR-4** — carte inconnue → « Carte invalide ».
- **JO-5 / SE-2** — le résultat d'un scan est annoncé sur toutes les pages, sauf quand il ne
  fait rien (code vide).
- **TI-11** — la recherche des tirages est supprimée.
- **JO-1** — nombre ≤ existants : champ en erreur, bouton bloqué, « Déjà n joueurs existants ».
- **Cartes au-delà des joueurs** — proposer « Générer les joueurs supplémentaires ».
- **EV-8** — confirmation si des badgeages existent.
- **JO-2** — retenir la fermeture le temps d'écrire, sans question à l'utilisateur.
- **SE-7** — rien à afficher : la génération des sessions reste une case du formulaire
  d'événement.
- **Badgeage à l'horaire du poste** — voulu ; le badgeage manuel est l'ouverture d'une session
  à la main.
- **Nom du joueur** — laissé en l'état.

## Suggestions

- **Un son** au scan (réussi / refusé) : la douchette bippe à la lecture, pas au résultat ; un
  second son dirait si l'application a accepté. Utile en salle, hors périmètre.
