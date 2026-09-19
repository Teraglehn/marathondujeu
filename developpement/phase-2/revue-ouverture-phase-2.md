# Revue d'ouverture — phase 2

Faite le 2026-09-19, à la clôture de la phase 1 (dernier commit `262b23e`).

## Constats

| Contrôle | Résultat |
|---|---|
| `flutter --version` | 3.47.5 stable, Dart 3.13.4 |
| `flutter pub get` | résout depuis pub.dev seul ; `pubspec.yaml` sans `any` |
| `flutter analyze` | `No issues found!` |
| `flutter test` | 17 tests, verts (tirage, égalité, persistance) |
| `flutter build windows` | passe |
| Exécution | l'application démarre ; base dans `%APPDATA%\com.saroc\marathondujeu` |

- Plafond de version : `isar_community_generator` 3.3.2 retient `analyzer` < 11, donc riverpod
  3.1, freezed 3.2, build_runner 2.15. Sans effet sur la phase.
- Lots rattachés : L04, L05, L06 — leurs rapports naîtront dans ce dossier. L09 reste en réserve.

## Questions ouvertes à l'ouverture

- L05 touche le schéma `Event` (cartes par ligne / page, orientation, taille de police) sur une
  base qui a servi : méthode, partie I, § 12, à appliquer dans le rapport.
- `throw`/`assert` : plus aucun garde-fou brut dans le code ; une convention d'erreur nommée
  n'est pas actée. À poser si un lot en a besoin.
