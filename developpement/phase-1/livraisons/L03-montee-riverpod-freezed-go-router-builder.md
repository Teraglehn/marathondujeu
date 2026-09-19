# L03 — Montée Riverpod 3, freezed 3, go_router_builder 4

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19 avec L01 — L01 Q2, livré le 2026-09-19) · **Dépend de L01** : `isar_generator` 3.1.8 est ce
qui retient `analyzer` en 6.x, et avec lui tous les générateurs.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Porter les générateurs et leurs bibliothèques sur leurs majeures courantes, régénérer, et sortir
d'`analyze` sans warning. Aucune fonctionnalité ne change.

## Périmètre

| Cible | Aujourd'hui | Visé |
|---|---|---|
| `riverpod`, `flutter_riverpod`, `riverpod_annotation` | 2.6.1 | 3.x |
| `riverpod_generator` | 2.4.0 | 4.x |
| `riverpod_lint`, `custom_lint` | 2.3.10, 0.6.4 | ceux qui vont avec riverpod 3 |
| `freezed`, `freezed_annotation` | 2.5.2, 2.4.4 | 3.x |
| `go_router_builder` | 2.7.1 | 4.x (`go_router` 16.2.4 reste) |
| `analyzer` (dev) | épinglé `^6.4.1` | ligne retirée : la contrainte vient des générateurs |
| Code touché | 12 fichiers `@riverpod`, `services_injector.dart`, 4 classes `@freezed`, `routes.dart` (8 routes typées, 1 shell) | ce que les guides de migration imposent, rien de plus |
| Générés | `*.g.dart`, `*.freezed.dart`, `routes.g.dart` | régénérés et versionnés |
| Warnings | 9 (7 `_XxxRef` générés inutilisés, 2 imports inutilisés dans `image_form_field.dart`) | 0 |

### Hors périmètre

- Les ~30 `info` d'`analyze` (`Color.red/green/blue` dépréciés dans `color.service.dart`,
  `strict_top_level_inference`, `use_build_context_synchronously`) — sauf ce que la montée fait
  passer en erreur (Q1).
- Montée de Flutter lui-même (3.35 reste) et des autres dépendances (`pdf`, `printing`,
  `file_picker`…), sauf si la résolution l'impose ; alors la version prise est notée dans le rapport.
- Toute retouche de comportement ou de modèle (L02).

## Critère de fin

1. `flutter pub get` résout avec les majeures visées ; `pubspec.lock` en fait foi.
2. `dart run build_runner build --delete-conflicting-outputs` termine sans erreur.
3. `flutter analyze` : **0 erreur, 0 warning**. Le nombre d'`info` est relevé dans le rapport.
4. `flutter test` : vert (les tests de L02 s'ils sont livrés).
5. `flutter build windows` passe.
6. Recette : sélection d'un événement, ouverture d'une session, badgeage d'un joueur, calcul d'un
   tirage, génération d'une planche de cartes — chaque écran s'ouvre et se comporte comme avant.

**Constaté le 2026-09-19** :
1. `pubspec.lock` : riverpod / flutter_riverpod / riverpod_annotation / riverpod_generator /
   riverpod_lint 3.0.3, custom_lint 0.8.0, freezed 3.2.3, freezed_annotation 3.1.0,
   go_router_builder 4.1.1, analyzer 7.6.0, build_runner 2.6.0, source_gen 3.1.0.
2. `build_runner` : `Built with build_runner`, 40 sorties.
3. `flutter analyze` : 0 erreur, 0 warning, **13 infos** (avant : 9 warnings, 30 infos).
4. `flutter test` : 17 tests, verts (ceux de L02).
5. `flutter build windows` : construit.
6. Recette : à faire par Bastien.
Code touché par les guides : `routes.dart` (mixin `with $XxxRoute` sur les 8 routes — pas sur le
`ShellRouteData`, qui n'en génère pas), 4 classes `@freezed` → `abstract class`. Riverpod 3 n'a
demandé **aucun** changement de code source ; les `_XxxRef` ont disparu du généré.

## Questions déterminantes

Aucune.

## Questions non déterminantes

- **Q1 — Corriger les `info` au passage ?** Trois familles, toutes hors sujet pour la montée.
  **Défaut : non.** Seule exception : une `info` qui devient erreur avec les nouvelles versions se
  corrige, et se note.

## Choix d'implémentation

- **C1 — Migration par les guides officiels, pas par tâtonnement.** Riverpod 2→3, freezed 2→3,
  go_router_builder 2→4 : on applique la liste de chaque guide au code concerné. Ce qui n'est pas
  dans un guide n'est pas touché.
- **C2 — freezed 3 : les 4 classes passent `abstract class`** (`SearchCriteria`, `PlayerCard`,
  `EditorState`, `MainState`). C'est le changement obligatoire de la majeure ; la syntaxe
  d'union n'est pas utilisée ici.
- **C3 — Riverpod 3 : `Ref` unique.** Les pods utilisent déjà `Ref` ; les `_XxxRef` dépréciés
  disparaissent du généré, ce qui retire 7 warnings et une douzaine d'`info`.
- **C4 — Une montée à la fois, dans l'ordre analyzer → riverpod → freezed → go_router_builder**,
  avec `build_runner` et `analyze` entre chaque. Un échec se localise ainsi à une seule montée.
- **C5 — `analyzer` n'est plus épinglé.** La ligne est retirée de `dev_dependencies` ; si une
  contrainte reste nécessaire, elle est notée ici avec sa raison.

## Questions tranchées

- **Q2 — Ce lot dépend-il de L01 ?** → **Oui.** `isar_generator` 3.1.8 contraint `analyzer` <7 ;
  `isar_community_generator` 3.3.x exige `analyzer` ≥ 7.4.5 (constaté le 2026-09-19). Et la
  réciproque est vraie : L01 ne résout pas sans L03 — voir L01 Q2. Les deux s'exécutent ensemble.
  *(revue d'ouverture, 2026-09-18 ; pilotage du 2026-09-19)*

## Suggestions

- Riverpod 3 apporte le *offline persistence* et les *mutations* expérimentales : rien à en faire
  ici, ne pas les adopter dans ce lot.
- Une fois le lot livré, `flutter pub outdated` devient lisible : bon moment pour lister ce qui
  reste en retard, dans une note de pilotage, pas dans un lot.
