# L11 — Fiche joueur : QR code, sessions badgées, badgeage manuel

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Dépend de L10 (livré) : le
formulaire est repris tel que L10 l'a laissé.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

L'éditeur latéral d'un joueur (`EditDrawerWidget` → `player_edit_form.dart`) devient une
**fiche** : l'image de son QR code, la liste des sessions de l'événement — verte si le joueur y
a badgé, grisée sinon — et un mode manuel pour badger ou dé-badger une session d'un clic
(Bastien, 2026-09-19). Aujourd'hui le formulaire n'expose que le nom, le QR code en texte et
le bonus.

## Périmètre

| Cible | Détail |
|---|---|
| `src/ui/forms/player_edit_form.dart` | image du QR code (C1) ; grille des sessions (C2) ; interrupteur *Mode manuel* (C4) ; clic sur une session en mode manuel → badge / dé-badge **en attente**, affiché tout de suite, écrit à *Enregistrer* (Q2, C7) |
| `src/services/data/event_service.dart` | `setPlayerSessions(player, added, removed)` : ajoute et retire le joueur des sessions données, une seule transaction (Q1, C7). Au passage, `await` sur la sauvegarde de `forceAddPlayerToSession` (Bastien, 2026-09-19) |
| `test/` | `setPlayerSessions` : ajout puis retrait, persistés sur une vraie base Isar |
| Textes | *Badgeage manuel* : clé existante `page_session_manualAdd` réutilisée et **renommée** (C5) ; légende présent / absent / badgeage manuel, aide du bonus (`form_player_*`) |
| Ajouté à la recette (Bastien, 2026-09-19) | sessions en **cartes** comme la liste des sessions (C2) ; QR code 200 px avec son code dessous, non éditable ; aide « chaque point bonus ajoute un jeton » ; boutons *Enregistrer* / *Annuler* / *Supprimer* pleins et plus grands **dans les quatre éditeurs latéraux** ; `PlayerSessionScanner` sans `UniqueKey` (C8) |

### Hors périmètre

- La page session et la douchette : inchangées. Le scan dans la liste des joueurs ouvre déjà
  la fiche (`PlayerSessionScanner` → `editPlayer`).
- Le champ *Bonus* et ses boutons (L10). Le décalage L10 C3 (bonus modifié dans la liste pendant
  que la fiche est ouverte) n'est repris que s'il gêne à la recette.
- Imprimer ou exporter le QR code : la génération de cartes est le sujet de L05.
- La largeur du tiroir (50 % de la fenêtre) : inchangée, sauf si la grille ne tient pas (C2).

## Critère de fin

1. Ouvrir un joueur : son QR code s'affiche, lisible à la douchette ; toutes les sessions de
   l'événement sont listées, dans l'ordre, celles où il a badgé en vert, les autres grisées.
2. Hors mode manuel, cliquer une session ne fait rien.
3. Mode manuel actif : cliquer une session grisée la passe en vert dans la fiche ; après
   *Enregistrer*, la page session compte un joueur de plus et la carte du joueur dans la liste
   une session de plus. Cliquer une session verte la repasse en gris, et l'inverse partout.
4. *Annuler* après un badgeage manuel : rien n'a changé, ni dans la fiche rouverte, ni sur la
   page session (Q2). *Enregistrer* écrit tout d'un coup.
5. Redémarrage de l'application : badgeages et dé-badgeages conservés.
6. `flutter analyze` propre, `flutter test` vert (test du service ajouté), `flutter build
   windows` passe.

**Constaté le 2026-09-19** :
1–4. Recette Bastien : « L11 OK », après neuf retouches (voir la recette).
5. Non vérifié à part : `setPlayerSessions` écrit par `Isar.putAll` + `links.save`, testé sur base.
6. `flutter analyze` : `No issues found!` ; 20 tests verts (3 nouveaux) ; `flutter build windows`
construit.
Écarts : les boutons des trois autres éditeurs latéraux et le scanner (C8) sont hors du périmètre
initial ; le texte « Mode manuel » de la page session devient « Badgeage manuel » (clé partagée).

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2, Q3 tranchées le 2026-09-19.

## Choix d'implémentation

- **C1 — QR code par `PrettyQrView`** sur `PlayerCard(code: player.qrcode).getQrImage()` — le
  même rendu que les cartes imprimées, dépendance déjà présente. Taille fixe, 120 px, en tête
  de fiche à côté du nom.
- **C2 — Sessions en `Wrap` de cartes**, la même carte que la liste des sessions : bille du numéro,
  heure de début en titre, heure de fin en sous-titre, carte grisée si la session est passée.
  La bille passe au **vert** quand le joueur a badgé. Triées par heure de début ; la fiche
  défile. *(Puces `FilterChip` d'abord, remplacées à la recette — Bastien, 2026-09-19.)*
- **C3 — L'état « badgé » se lit côté session** (`session.players.contains(player)`), depuis le
  pod `sessions` de l'événement, corrigé des clics en attente (C7). Pas de
  `player.sessions.load()` : ce backlink ne se rafraîchit pas tout seul après un badgeage.
- **C4 — Mode manuel : un `Switch`**, éteint à l'ouverture de la fiche, hors du `Form`. Éteint,
  les puces sont inertes.
- **C5 — Le texte « Mode manuel » est réutilisé** (`page_session_manualAdd`) plutôt que
  dupliqué : même concept, même mot.
- **C6 — Test du service, pas du widget** : `setPlayerSessions` en ajout puis en retrait sur la
  base de test, relecture de `session.players`. La fiche se constate à la recette (critères 1
  à 3), comme L04 et L10.
- **C7 — Les clics en attente vivent dans l'état du formulaire** : deux ensembles
  d'identifiants de sessions, *à ajouter* et *à retirer* ; un clic fait entrer la session dans
  l'un ou l'en sort. *Enregistrer* sauvegarde le joueur, puis `setPlayerSessions` ; *Annuler*
  jette les deux ensembles. `forceAddPlayerToSession` reste pour la douchette, inchangé.
- **C8 — `PlayerSessionScanner` devient stateful, sans `UniqueKey`** : la clé recréait tout le
  sous-arbre à chaque rebuild de la page — le défilement de la liste des joueurs repartait en
  haut. Le callback donné à `BarcodeKeyboardListener` est unique et lit `widget` et les pods au
  moment du scan. Constaté à la recette de L11, antérieur à L10.

## Questions tranchées

- **Q1 — Le mode manuel permet-il de dé-badger ?** → **(a) oui** : seul moyen de corriger un
  badgeage par erreur. Écarté : *(b)* badger seulement. *(Bastien, 2026-09-19)*
- **Q2 — Un badgeage manuel s'écrit-il tout de suite, ou à *Enregistrer* ?** → **(b) à
  *Enregistrer***, comme le bonus (L10 Q3) : la fiche a une seule règle, *Annuler* annule tout.
  Écarté : *(a)* écriture immédiate, comme la page session. *(Bastien, 2026-09-19)*
- **Q3 — Faut-il confirmer un dé-badgeage ?** → **(a) non** : le mode manuel est le geste
  d'engagement, l'inverse est à un clic, et *Annuler* reste possible (Q2). Écarté : *(b)* une
  boîte de dialogue. *(Bastien, 2026-09-19)*

## Suggestions

Aucune. *(Le `save` sans `await` de `forceAddPlayerToSession`, relevé à la rédaction, a été corrigé
dans le lot — Bastien, 2026-09-19.)*
