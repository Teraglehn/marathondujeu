# Phase 1 — rapport de livraisons

Une synthèse courte par lot livré : ce qui a été livré, et les écarts assumés. Le détail reste dans
le rapport du lot, dans `livraisons/`.

## 2026-09-19 — L01, L02, L03, livrés ensemble

**L01 — Migration Isar → `isar_community`.** `isar`, `isar_flutter_libs`, `isar_generator` 3.1.8
(hébergeur mort) remplacés par `isar_community*` **3.3.0** sur pub.dev ; imports réécrits ;
résolution constatée depuis un cache pub vierge. La base existante s'ouvre avec la nouvelle lib.
*Écart* : 3.3.0 et non 3.3.2, qui exige `analyzer` 8, incompatible avec Dart 3.9.

**L03 — Montée Riverpod 3, freezed 3, go_router_builder 4.** Inséparable de L01 (L01 Q2) :
analyzer 7.6, riverpod 3.0.3, freezed 3.2.3, go_router_builder 4.1.1, épingle `analyzer`
retirée. `analyze` : 0 erreur, 0 warning (13 infos, laissées — L03 Q1). Riverpod 3 n'a demandé
aucun changement de source ; go_router_builder 4 impose un mixin par route, freezed 3 des
classes `abstract`.

**L02 — Corrections du modèle et du tirage.** `operator ==` de `Event`, `Draw`, `DrawWinner`
corrigé ; `_getPlayerList` ne mute plus les liens du tirage ; base déplacée dans
`%APPDATA%\com.saroc\marathondujeu` avec reprise par copie de l'ancien fichier (intact) ;
`com.example` → `com.saroc` partout ; premiers tests (17, sur une vraie base Isar temporaire).
*Écarts* : `DrawRepository.write` ne sauvegardait pas `requiredPlayers` — corrigé, hors liste
initiale ; la copie de tirage (`createDrawFromDraw`) est sortie du lot → L06.

## 2026-09-19 — L07

**L07 — Hygiène du code.** `flutter analyze` à `No issues found!` : couleurs dépréciées
converties (même échelle 0–255), types de retour annotés (`theme.dart`, `Debouncer.run`,
`IconSelector.itemBuilder`), `BuildContext` protégé après `await`. *Écart assumé* : un seul
changement de comportement, décidé (Q1 b) — annuler la date n'ouvre plus le sélecteur d'heure.

## 2026-09-19 — L08

**L08 — Montée de Flutter et des dépendances.** Flutter 3.47.5 (Dart 3.13), `flutter pub upgrade
--major-versions` : isar_community 3.3.2, riverpod 3.1 / annotation et generator 4.0, go_router 18,
google_fonts 8, file_picker 13, flex_color_picker 4, etc. `pubspec.yaml` sans `any`, carets sur
les versions résolues. *Écarts assumés* : `isar_community_generator` plafonne `analyzer` < 11,
donc riverpod 3.1 (pas 3.4), freezed 3.2 (pas 4), build_runner 2.15 ; `custom_lint` et
`riverpod_lint` retirés (Q3), leur système de plugin étant déprécié par Dart 3.13.
