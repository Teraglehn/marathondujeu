# L01 — Migration Isar → `isar_community`

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Exécuté avec L03 (Q2) · Ne dépend d'aucun lot. L03 dépend de celui-ci.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Remplacer les paquets Isar 3.1.8 servis par `pub.isar-community.dev` — hébergeur mort, dépôt GitHub
archivé — par leur republication sur pub.dev, `isar_community` 3.3.2 (API v3). Le projet ne doit
plus dépendre du cache pub local pour se construire.

## Périmètre

| Cible | Détail |
|---|---|
| `pubspec.yaml` | `isar`, `isar_flutter_libs`, `isar_generator` → `isar_community`, `isar_community_flutter_libs`, `isar_community_generator` ; blocs `hosted:` et ancre `isar_version` retirés |
| Imports | `package:isar/isar.dart` → `package:isar_community/isar.dart` dans les 15 fichiers de `lib/` qui l'importent (6 collections, 7 dépôts, `isar_client.dart`, `image_form_field.dart`) |
| Générés | `*.g.dart` des collections régénérés par `build_runner` et versionnés |
| `pubspec.lock` | aucune ligne `pub.isar-community.dev` |
| Base existante | ouverture d'une **copie** de base produite par la version actuelle, avec la nouvelle bibliothèque (Q1) |

### Hors périmètre

- Toute correction de modèle ou de logique métier (L02).
- Toute autre montée de version (L03).
- Isar 4 : le fork reste en API v3, aucun changement de format ni d'API.
- Déplacement du dossier de la base (L02).

## Critère de fin

1. `flutter pub get` résout **depuis pub.dev seul** — constaté avec `PUB_CACHE` pointé sur un
   dossier vide, sans toucher au cache habituel (C2).
2. `flutter analyze` : 0 erreur, pas plus de warnings qu'avant (9).
3. `flutter build windows` passe.
4. L'application ouvre une copie de la base actuelle et affiche ses événements, joueurs et
   sessions. **Si la copie ne s'ouvre pas, le constat est noté et le lot livre quand même** (Q1).
   Le résultat, dans un sens ou dans l'autre, est écrit dans le rapport : il décide L02 Q1.

**Constaté le 2026-09-19** :
1. `PUB_CACHE` sur un dossier vide → `Got dependencies!`, `isar_community*` 3.3.0 tirés de pub.dev ;
   `pubspec.lock` sans `pub.isar-community.dev`.
2. `flutter analyze` : 0 erreur, 0 warning (13 infos, hors périmètre).
3. `flutter build windows` : `marathondujeu.exe` construit.
4. Copie de la base ouverte avec `isar_community` 3.3.0 : 2 événements (« Marathon du jeu »,
   « Marathon du jeu 2026 »), 500 joueurs, 54 sessions, 6 tirages. → L02 Q1 = (a).

## Questions déterminantes

Aucune — Q1 et Q2 tranchées le 2026-09-19.

## Questions non déterminantes

Aucune.

## Choix d'implémentation

- **C1 — Renommage sec, aucune abstraction.** Trois noms de paquet, un chemin d'import : un
  remplacement mécanique, pas de façade.
- **C2 — Contrôle de résolution sans purger le cache.** `CLAUDE.md` interdit de purger le cache
  pub avant la migration. Le contrôle se fait en pointant `PUB_CACHE` sur un dossier temporaire :
  si `pub get` y résout, le projet ne dépend plus de l'ancien hébergeur.
- **C3 — La base se teste sur une copie.** Le fichier `default.isar` n'est jamais ouvert en place
  par la version migrée avant que le critère 4 soit constaté.

## Questions tranchées

- **Q1 — La base produite par la version actuelle doit-elle rester lisible après migration ?**
  → **Si possible oui ; sinon, pas bloquant.** On vérifie sur une copie avant livraison ; un
  échec se note dans le rapport, il ne suspend pas la livraison. Sur ce poste, une base existe :
  `%LOCALAPPDATA%\com.example\marathondujeu\default.isar` (1 Mo, dernière écriture 2026-09-19) —
  **base de test / dev**, pas celle de l'édition 2025 (recette du 2026-09-19).
  *(Bastien, 2026-09-19)*
- **Q2 — L01 ne se sépare pas de L03.** Constat du 2026-09-19, à l'essai de résolution :
  - `isar_community_generator` 3.3.2 exige `analyzer` ≥ 8 ; 3.3.0 / 3.3.1 exigent ≥ 7.4.5 ;
    3.2.1 exige `analyzer` 6.9 **avec macros**, mort sous Dart 3.9 (Flutter 3.35).
  - `analyzer` 7 impose `custom_lint` 0.8, `riverpod_lint` 3, donc `riverpod` 3 ; et `freezed` 2
    est incompatible avec le générateur 3.3.x (`source_gen`).
  - Seule résolution trouvée : `isar_community` **3.3.0** + `analyzer` 7.6 + riverpod 3.0.3 +
    freezed 3.2.3 + go_router_builder 4.1.1 — c'est le périmètre de L03.
  → **(a) : L01 et L03 s'exécutent ensemble, une seule livraison ; L02 suit dans la même
  séance.** *(Bastien, 2026-09-19)* Options vues :
  - *(a)* **exécuter L01 et L03 ensemble**, une seule livraison, les deux rapports gardent leur
    critère de fin ;
  - *(b)* abandonner la migration et rester sur le cache pub local (le build ne tient que par lui).

## Suggestions

- Si la copie ne s'ouvre pas (Q1), garder l'ancien fichier intact et le signaler : la version
  actuelle du code le lit encore, rien n'est perdu tant qu'on ne l'écrase pas.
