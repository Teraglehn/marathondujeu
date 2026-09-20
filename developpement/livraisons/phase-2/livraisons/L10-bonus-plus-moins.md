# L10 — Bonus d'un joueur : boutons « + » et « − »

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot. Touche
`player_edit_form.dart` comme L11 : à livrer **avant** L11, qui reprendra le formulaire tel
que L10 l'aura laissé.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Donner ou retirer un bonus à un joueur en un clic, sans passer par la saisie d'un nombre. Le
bonus vaut un jeton de plus au tirage (`Player.getTokenCount`). Deux endroits : la carte du
joueur dans la liste, et l'éditeur latéral du joueur (Bastien, 2026-09-19).

## Périmètre

| Cible | Détail |
|---|---|
| `src/ui/pages/player_list/player_list_page.dart` | tuile *Bonus* de chaque carte (ligne 125) : `trailing` avec « − » et « + », sauvegarde immédiate (C1). Le `IconButton` commenté ligne 131 et `plusOneBonus` (ligne 32) servent de base (C2) |
| `src/ui/forms/player_edit_form.dart` | champ *Bonus* (ligne 110) : « − » et « + » autour du champ texte (Q2), pris en compte à « Enregistrer » (Q3) |
| Borne basse | le bonus ne descend pas sous 0 (Q1) |
| Billes de compteur | sessions, bonus, jetons : **grisées à zéro** (ajouté à la recette, Bastien, 2026-09-19) |
| Textes | aucun nouveau : icônes seules (`Icons.remove`, `Icons.add`) |

### Hors périmètre

- Le poids du bonus au tirage, le calcul du tirage.
- Le reste de la fiche joueur : QR code, sessions, badgeage manuel (L11).
- Un bonus négatif (malus) : hors sujet tant que Q1 n'en fait pas la demande.

## Critère de fin

1. Liste des joueurs : « + » sur une carte → le bonus affiché passe à 1 **et** la ligne *jetons*
   augmente d'un, sans rechargement ni réouverture. « − » ramène à 0 ; à 0, « − » est désactivé.
2. Le clic sur « + » / « − » n'ouvre **pas** l'éditeur latéral (la carte est un `InkWell`).
3. Éditeur latéral : « + » puis *Enregistrer* → la carte du joueur affiche le nouveau bonus.
   *Annuler* après « + » → rien n'a changé.
4. Redémarrage de l'application : les bonus sont conservés.
5. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-19** :
1–3. Recette Bastien : « L10 ok », après quatre retouches (voir la recette).
4. Non vérifié à part : la sauvegarde passe par `Isar.put`, comme le formulaire déjà en place.
5. `flutter analyze` : `No issues found!` ; 17 tests verts ; `flutter build windows` construit.
Écart : la sauvegarde dans la liste est différée de 400 ms (C1), pas immédiate comme prévu.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2, Q3 tranchées le 2026-09-19.

## Choix d'implémentation

- **C1 — Dans la liste, la sauvegarde est automatique, regroupée** : la carte réagit au clic
  (`setState`), les joueurs touchés sont sauvegardés en une fois 400 ms après le dernier clic
  (`Debouncer` existant, `PlayerService.saveAll` ajouté), et à la sortie de la page. Constaté à
  la recette (2026-09-19) : sauvegarder à chaque clic fait recharger toute la liste à chaque
  fois — lent, et saccadé sur plusieurs clics.
- **C2 — `plusOneBonus` passe en `ref.read`** : `ref.watch` hors de `build` (ligne 35) est un
  usage incorrect de Riverpod. Une seule méthode `_addBonus(player, delta)` couvre « + » et « − ».
- **C3 — Éditeur ouvert sur le joueur qu'on incrémente depuis la liste** : le champ *Bonus* du
  formulaire garde l'ancienne valeur ; *Enregistrer* la réécrirait. Limite acceptée : le
  formulaire est refait en L11. À constater à la recette, pas à corriger ici.
- **C4 — Pas de test de widget** : deux boutons et une borne ; la recette (critères 1 à 3) le
  constate mieux. Même choix que L04 C3.

## Questions tranchées

- **Q1 — Borne basse du bonus ?** → **(a) 0**, « − » désactivé à 0. Écarté : *(b)* négatif
  autorisé, comme malus. Le champ texte refuse déjà le signe (`FormattersService.integer`).
  *(Bastien, 2026-09-19)*
- **Q2 — Dans l'éditeur, garder le champ texte ?** → **(a) oui**, « − » et « + » de part et
  d'autre : la saisie directe reste possible pour un bonus élevé. Écarté : *(b)* un simple
  afficheur entre les deux boutons. *(Bastien, 2026-09-19)*
- **Q3 — Dans l'éditeur, « + » enregistre-t-il tout de suite ?** → **(a) non**, à *Enregistrer*
  comme les autres champs ; *Annuler* reste honnête. Écarté : *(b)* sauvegarde immédiate comme
  dans la liste. *(Bastien, 2026-09-19)*

## Suggestions

- `DrawService.getWinner` : si aucun joueur éligible n'a de jeton, `lots` est vide et
  `nextInt(0)` lève une exception. Constaté en lisant le code, hors périmètre — à reprendre dans
  L06 (volet éditeur des tirages) ou un lot dédié.
