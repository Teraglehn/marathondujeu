# L04 — Liste des gagnants d'un tirage : retour à la ligne et défilement

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Sur la page des tirages, quand un tirage désigne beaucoup de gagnants, la liste des gagnants
déborde à droite : la fin est invisible et ne défile pas (constaté sur l'édition 2025). Les
gagnants doivent tous être visibles.

## Périmètre

| Cible | Détail |
|---|---|
| `src/ui/pages/draw_list/draw_list_page.dart` | le `subtitle` de la tuile d'un tirage est un `Row` des cartes de gagnants (ligne 91) : passer à un `Wrap` (Q1) |
| Ordre | afficher les gagnants **par position** (C2) : `draw.winners` est un lien Isar, sans ordre garanti |
| Textes | aucun nouveau |

### Hors périmètre

- Le contenu d'une carte de gagnant (numéro de position + numéro de carte) : inchangé.
- Le calcul du tirage, le nombre de gagnants, la copie d'un tirage (L06).
- Les autres listes de l'application.

## Critère de fin

1. Un tirage à 30 gagnants sur une fenêtre de 1280 px de large : toutes les cartes sont
   visibles, réparties sur plusieurs lignes ; aucune bande jaune et noire de débordement dans la
   console ni à l'écran.
2. La liste des tirages défile quand plusieurs tirages hauts s'empilent.
3. Les gagnants apparaissent dans l'ordre N°1, N°2, …
4. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-19** :
1–3. Recette Bastien, base de test : « parfait » après correction du `Row` interne (C1).
4. `flutter analyze` : `No issues found!` ; 17 tests verts ; `flutter build windows` construit.
Écart : le tri utilise `toList()..sort(...)` — `sortedBy` vient du paquet `collection`, qui n'est
pas une dépendance directe.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 tranchée le 2026-09-19.

## Choix d'implémentation

- **C1 — `Wrap` avec un espacement de 8 px**, en remplacement du `Row`, sans changer les cartes.
  Constaté à la recette : le `Row` interne de chaque carte prenait toute la largeur →
  `mainAxisSize: MainAxisSize.min` ajouté (2026-09-19).
- **C2 — Tri par `position` avant affichage**, dans la page (`toList()..sort`), pas dans le modèle : le
  lien Isar reste tel quel.
- **C3 — Pas de test de widget** : le lot change une disposition ; la recette (critère 1) la
  constate mieux qu'un test de mise en page.

## Questions tranchées

- **Q1 — Retour à la ligne, ou défilement horizontal ?** → **(a) `Wrap`** : la tuile grandit,
  tout est visible d'un coup, la liste des tirages défile verticalement. Écarté : *(b)* une
  ligne à défilement horizontal, qui laisse les derniers gagnants hors champ.
  *(Bastien, 2026-09-19)*

## Suggestions

Aucune. *(Afficher un nom de joueur a été proposé puis écarté : les joueurs ne sont pas saisis
dans l'application, les cartes sont prégénérées et le « nom » d'un joueur est son numéro de
carte — Bastien, 2026-09-19.)*
