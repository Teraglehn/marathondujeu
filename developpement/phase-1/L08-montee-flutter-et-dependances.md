# L08 — Montée de Flutter et des dépendances restées en retard

Statut : **à faire** (ouvert le 2026-09-19) · Ne dépend d'aucun lot. À jouer **après L07**
(un `analyze` à zéro rend visible ce que la montée introduit).

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Monter Flutter au-delà de 3.35 (Dart 3.9), puis toutes les dépendances que Dart 3.9 bloquait ou
que L03 a laissées en retard, et fixer enfin des contraintes de version dans `pubspec.yaml`.
Aucune fonctionnalité ne change.

## Périmètre

| Cible | Aujourd'hui | Visé |
|---|---|---|
| Flutter | 3.35.4 stable (Dart 3.9) | la stable courante au moment du lot (C1) |
| `environment.sdk` | `>=3.1.5 <4.0.0` | la borne basse du Dart installé |
| Bloqué par Dart 3.9 | riverpod 3.0.3, riverpod_annotation 3.0.3, riverpod_generator 3.0.3, riverpod_lint 3.0.3, freezed 3.2.3, isar_community 3.3.0, build_runner 2.6.0 | riverpod 3.4, riverpod_annotation / riverpod_generator 4, riverpod_lint 3.1, freezed 4, isar_community 3.3.2, build_runner 2.16 — ou ce que la résolution donne |
| Majeures atteignables déjà | go_router 16.2.4, google_fonts 6.3.2, file_picker 10.3.3 | 17 / 18, 8, 11 / 13 |
| Mineures | pdf 3.11.3, printing 5.14.2, pretty_qr_code 3.5.0, uuid 4.5.1, flex_color_picker 3.7.1 | dernières |
| Contraintes | 15 dépendances en `any` | `^x.y.z` sur la version résolue (C3) |
| Générés | tous | régénérés et versionnés |

*(Relevé `flutter pub outdated` du 2026-09-19. À refaire au démarrage du lot.)*

### Hors périmètre

- Isar 4 : le fork reste en API v3 ; rien n'existe au-delà de 3.3.2.
- Toute retouche de code au-delà de ce que les guides de migration imposent (freezed 4,
  riverpod_generator 4, go_router 17/18, file_picker 11+, google_fonts 8).
- L'atteinte de « zéro info » : c'est L07. Ce lot ne doit pas en réintroduire.

## Critère de fin

1. `flutter --version` : la stable visée ; `pubspec.yaml` porte la borne `sdk` correspondante.
2. `flutter pub outdated` : colonne *Resolvable* vide pour les dépendances directes, ou chaque
   ligne restante justifiée dans ce rapport.
3. `pubspec.yaml` : plus aucun `any`.
4. `build_runner` termine ; `flutter analyze` sans erreur ni warning, et **pas plus d'info qu'à
   l'entrée du lot** ; `flutter test` vert ; `flutter build windows` passe.
5. Recette : le parcours de L03 (sélection d'un événement, session, badgeage, tirage, planche
   de cartes) — plus la sélection de fichier image (file_picker) et le rendu des polices
   (google_fonts), touchés par des majeures.

## Questions déterminantes

Aucune.

## Questions non déterminantes

- **Q1 — Flutter global ou par projet (FVM) ?** `flutter upgrade` change le SDK pour tout le
  poste ; FVM l'épingle par dépôt. Un seul projet Flutter sur ce poste à ce jour, pas de FVM
  installé. **Défaut : global**, version notée dans `CLAUDE.md`.
- **Q2 — Une montée ou plusieurs commits ?** *(a)* un seul geste, `flutter pub upgrade
  --major-versions` après la montée de Flutter, une recette ; *(b)* Flutter d'abord, livré seul,
  puis les dépendances. **Défaut : (a)** — la moitié des dépendances ne bouge pas sans Flutter,
  et une seule recette suffit.

## Choix d'implémentation

- **C1 — La stable du jour, pas une version choisie à l'avance.** Elle est notée dans ce rapport
  et dans `CLAUDE.md` au moment du lot.
- **C2 — Guides de migration officiels**, comme en L03 : freezed 4, riverpod_generator 4,
  go_router (changelog 17 et 18), file_picker, google_fonts. Ce qui n'est pas dans un guide n'est
  pas touché.
- **C3 — Contraintes en caret sur la version résolue** (`^17.2.3`, pas `any`, pas `>=`). Le lock
  fait foi pour l'instant ; le caret protège des majeures involontaires à la prochaine
  résolution.
- **C4 — Une famille à la fois, `analyze` entre chaque** (Flutter → riverpod → freezed →
  go_router → le reste), comme L03 C4, même si tout part dans un seul commit.

## Questions tranchées

Aucune.

## Suggestions

- `flutter_lints` suit Flutter : une stable plus récente peut activer de nouvelles règles. Si
  elles remontent des `info`, les traiter ici plutôt que rouvrir L07.
