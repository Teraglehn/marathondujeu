# L08 — Montée de Flutter et des dépendances restées en retard

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot. À jouer **après L07**
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

**Constaté le 2026-09-19** :
1. Flutter **3.47.5** stable, Dart 3.13.4 ; `sdk: ^3.13.0`, `flutter: ">=3.47.0"`.
2. `flutter pub outdated`, dépendances directes restantes — toutes plafonnées par
   `isar_community_generator` 3.3.2 (`analyzer` < 11) : flutter_riverpod 3.1.0 (3.4.3),
   riverpod_annotation 4.0.0 (4.0.7), riverpod_generator 4.0.0+1 (4.0.9), freezed 3.2.3 (4.0.2,
   veut analyzer 14), build_runner 2.15.1 (2.16.1, veut analyzer 13). Rien d'autre.
3. `pubspec.yaml` : 0 `any`, carets sur les versions résolues ; `pub get` ne change pas le lock.
4. `build_runner` OK ; `flutter analyze` : `No issues found!` ; 17 tests verts ;
   `flutter build windows` construit ; l'exe démarre et tient.
5. Recette : à faire par Bastien.
Montées obtenues : isar_community 3.3.2, riverpod 3.1 / riverpod_annotation 4.0 /
riverpod_generator 4.0, go_router 18.0.1, go_router_builder 4.5, google_fonts 8.2, file_picker
13.1, flex_color_picker 4.0, pdf 3.13, printing 5.15, pretty_qr_code 3.6, uuid 4.6,
build_runner 2.15, analyzer 8.4.
Code touché : `image_form_field.dart` (file_picker 13 : `pickFile` + `WindowsOptions`,
`readAsBytes()` du `PlatformFile`) ; `repository_base.dart` (`buildQuery` marqué expérimental
par isar_community 3.3.2 → `ignore` commenté). Rien d'autre : riverpod_annotation 4, go_router 18,
google_fonts 8, flex_color_picker 4 n'ont rien demandé.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2 tranchées le 2026-09-19 ; Q3 tranchée à la recette.

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

- **Q3 — Garder `custom_lint` / `riverpod_lint` ?** Dart 3.13 déprécie l'ancien système de
  plugins d'analyse ; `custom_lint` 0.8.1 (dernière version) l'utilise encore → un warning
  permanent sur `analysis_options.yaml`, insupprimable. `riverpod_lint` 3.1.9 (nouveau système)
  exige analyzer 13, hors de portée (Q2 du constat). → **Retirés**, avec le bloc `plugins:` ;
  à remettre quand la chaîne suivra. *(défaut pris en cours de lot ; validé à la recette, Bastien, 2026-09-19)*

- **Q1 — Flutter global ou par projet (FVM) ?** → **Global** : aucun autre projet Flutter sur le
  poste. *(Bastien, 2026-09-19)*
- **Q2 — Une montée ou plusieurs commits ?** → **(a) un seul geste** : Flutter, puis
  `flutter pub upgrade --major-versions`, une recette. *(Bastien, 2026-09-19)*

## Suggestions

- `flutter_lints` suit Flutter : une stable plus récente peut activer de nouvelles règles. Si
  elles remontent des `info`, les traiter ici plutôt que rouvrir L07.
