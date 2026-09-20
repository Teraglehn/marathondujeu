# L17 — Modifications en cours : « Quitter / Revenir » à la fermeture d'un éditeur

Statut : **livré** (ouvert le 2026-09-19, livré le 2026-09-20) · Ne dépend d'aucun lot. Touche les quatre
formulaires : à livrer quand L13, L15 et L16 ne les modifient plus, ou juste avant L12.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Un éditeur latéral se ferme par *Annuler*, par la croix du titre, ou par un clic **hors du
tiroir** — et jette ce qui a été saisi, sans un mot. Un tirage long à régler, des badgeages
manuels en attente, un événement en cours de création : perdus sur un clic à côté. Le lot
demande confirmation **seulement si quelque chose a changé** (Bastien, 2026-09-19).

### Terminologie

- **Modifié** : le formulaire porte une valeur différente de celle de son objet à l'ouverture —
  un champ, un sélecteur, un interrupteur, ou un badgeage manuel en attente (fiche joueur).
- **Quitter** : fermer en jetant ; **Revenir** : rester dans l'éditeur.

## État du code (constats 2026-09-19)

- La fermeture passe par `EditorPod.close()` — appelé par *Annuler* / *Fermer*, par la croix du
  titre (L06), et par `onEndDrawerChanged(false)` du layout quand le tiroir se ferme par un clic
  hors de lui (`desktop.layout.dart`).
- Le clic hors du tiroir ferme le `Drawer` **avant** que le pod le sache : Flutter ferme, puis
  prévient. Pour demander avant, il faut empêcher la fermeture par le voile
  (`Scaffold.endDrawerEnableOpenDragGesture` ne suffit pas ; c'est le `drawerScrimColor` et le
  barrier qu'il faut rendre inertes) ou rouvrir le tiroir tant que la réponse n'est pas
  donnée.
- Aucun formulaire ne sait dire s'il est modifié : `Form` de Flutter n'a pas d'état « sale » ;
  les champs avec `controller` et ceux avec `initialValue` cohabitent.

## Périmètre

| Cible | Détail |
|---|---|
| Les quatre éditeurs | chacun expose **`isDirty`** (C1) : comparaison entre les valeurs à l'écran et l'objet ouvert ; fiche joueur : + badgeages en attente ; tirage : + groupes et sessions choisis |
| `EditDrawerWidget` / `EditorPod` | une seule voie de fermeture, **`requestClose()`** (C2) : si l'éditeur est modifié → modale « Modification en cours, voulez-vous quitter ? » *Quitter* / *Revenir* ; sinon fermeture directe |
| Clic hors du tiroir | ne ferme plus le tiroir tout seul : il passe par `requestClose()` (C3) |
| Échap | même chemin (C3) |
| Textes | fr/en |
| `docs/gestes.md` | TR-3 mis à jour dans le même commit |

### Hors périmètre

- Enregistrer automatiquement à la fermeture : non — *Quitter* jette, *Enregistrer* est un bouton.
- Un brouillon retrouvé à la réouverture : non.
- Les pages elles-mêmes (le générateur de cartes a ses réglages non enregistrés — hors tiroir,
  hors lot ; voir Suggestions).

## Critère de fin

1. Ouvrir un tirage, ne rien toucher, cliquer à côté : le tiroir se ferme sans question.
2. Ouvrir un tirage, changer le nombre de gagnants, cliquer à côté : la modale s'affiche ;
   *Revenir* → l'éditeur est là, la valeur aussi ; *Quitter* → fermé, rien d'enregistré.
3. Fiche joueur, badgeage manuel, cliquer une session, *Annuler* : la modale s'affiche (le
   badgeage en attente compte).
4. Fiche joueur, changer le bonus puis le remettre à sa valeur : fermer sans question (C1 compare
   des valeurs, pas des frappes).
5. Échap dans un éditeur modifié : la modale.
6. `flutter analyze` propre, `flutter test` vert (le calcul « modifié » de chaque formulaire est
   testé sans interface), `flutter build windows` passe.

## Constats du critère de fin (2026-09-20)

- 1 à 5 : recette de Bastien, rien de relevé (« reste OK »).
- 6 : `flutter analyze` sans problème ; `flutter test` 53 verts (`forms_dirty_test.dart` : 14 sur les
  quatre calculs « modifié ») ; `flutter build windows` passe.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 tranchée le 2026-09-20.

## Choix d'implémentation

- **C1 — `isDirty` compare des valeurs, pas des événements** : l'éditeur relit ses champs et
  ses ensembles et les compare à l'objet tel qu'ouvert (une copie des valeurs prise à
  l'ouverture). Une valeur modifiée puis remise ne compte pas. Chaque formulaire porte ce
  calcul dans une fonction pure, testée.
- **C2 — Une seule voie** : `EditorPod.requestClose()` interroge le formulaire courant (une
  interface `DirtyAware` exposée par une `GlobalKey`), ouvre la modale si besoin, puis
  `close()`. *Annuler*, la croix, Échap et le clic à côté l'appellent tous.
- **C3 — Le voile ne ferme plus le tiroir de lui-même** : le tiroir n'est plus le `endDrawer`
  du `Scaffold`. `DesktopLayout` pose lui-même, par-dessus la page, un `ModalBarrier` dont le
  clic appelle `requestClose()`, puis le `Drawer` glissé depuis la droite (`AnimatedSwitcher`).
  Échap est un `CallbackShortcuts` autour du tiroir. *Chemin « rouvrir le tiroir » écarté sans
  essai (2026-09-20) : le `Drawer` du `Scaffold` démonte son contenu dès qu'il est fermé — le
  formulaire, et la saisie avec, disparaissent avant que le pod soit prévenu ; rouvrir aurait
  montré un formulaire vierge.*
- **C4 — La modale a deux boutons, dans cet ordre** : *Revenir* (tonal, à gauche), *Quitter*
  (plein, couleur d'erreur, à droite). Échap dans la modale = *Revenir*.
- **C5 — Tests** : `isDirty` de chaque formulaire, sur des valeurs ; la mécanique du tiroir se
  constate à la recette.

## Questions tranchées

- **Q1 — Un formulaire neuf jamais touché : demander ?** → **(a) non**. C1 le donne de
  lui-même : les défauts de l'objet neuf sont les valeurs à l'ouverture *(Bastien, « reco pour
  tout », 2026-09-20)*.
- **Une modale « Modification en cours, voulez-vous quitter ? » *Quitter* / *Revenir*, seulement
  si le formulaire a été modifié** — *(Bastien, 2026-09-19)*.

## Suggestions

- **Le générateur de cartes** garde des réglages non enregistrés hors tiroir : quitter la page
  les perd de la même façon. Même modale, au changement de page — un petit lot, après celui-ci.
