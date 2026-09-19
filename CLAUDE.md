# CLAUDE.md — Marathon du Jeu (gestion des participants)

> ## ⚠ À lire avant d'agir — [`docs/methode-de-travail.md`](docs/methode-de-travail.md)
>
> **Comment on travaille ensemble** : le rythme (proposer un plan, **s'arrêter**, attendre le
> « vas-y »), les règles de commit, les rapports de lot et leur numérotation, la structure de
> `developpement/`, ce qui fait foi et dans quel ordre. Ces règles priment sur toute habitude par
> défaut. **Ouvrir ce document à chaque session, avant la première action.**
>
> **Amorçage de la mémoire** (environnement neuf) : les fiches de mémoire sont **dérivées** de ce
> document, jamais autoritaires. Les reconstituer depuis ses sections, chacune citant la sienne.
> Toute règle de méthode s'écrit **d'abord** dans le document ; la fiche est régénérée ensuite.

**Source de vérité** : le dossier `docs/` fait foi. Il est versionné avec le code et **éditable** :
quand Bastien acte une décision en session, la consigner dans le document concerné **dans le même
commit** que le code qu'elle justifie.

## First priority principles

*(en anglais à dessein : instructions adressées au modèle, pas documentation projet)*

- **Think before coding**. State your assumptions out loud. If the request is ambiguous ask. If a simpler approach exists, push back. Stop when you are confused, name what is unclear, do not just pick one interpretation and run.
- **Simplicity first**. Write the minimum code that solves the problem. No speculative abstractions. No flexibility nobody asked for. The test : would a senior engineer call this overcomplicated.
- **Surgical changes**. Touch only what the task requires. Do not improve neighboring code. Do not refactor what is not broken. Every changed line should trace back to the request.
- **Goal-driven execution**. Turn vague instructions into verifiable targets before writing a line. "Add validation" becomes "write tests for invalid inputs, then make them pass".
- **Write short**. Questions, findings, proposals, reports, tracking files: simple sentences, few
  words, one point per paragraph. Drop anything that does not change the reader's decision.
  Bastien reads to arbitrate — he will not read fifty paragraphs.

## Le projet

Application **desktop Windows** pour tenir le « Marathon du Jeu », **24 heures de jeu de société**.
Les joueurs viennent **badger à heure fixe** ; plus ils sont présents, plus ils ont de chances au
tirage au sort. Chaque joueur reçoit une carte imprimée avec un QR code ; une douchette le scanne
pour l'inscrire à la session en cours. Le logiciel a servi sur l'édition 2025.

**Les joueurs sont anonymes** *(acté 2026-09-19)* : les cartes sont prégénérées, personne ne
saisit de joueur dans l'application, et `Player.name` porte le **numéro de carte**.

Concepts, tels que le code les nomme : `Event` (l'événement, ses horaires, le gabarit de carte),
`Player`, `Session`, `PlayerGroup`, `Draw` (un tirage : contraintes de sessions et de joueurs
requis / exclus), `DrawWinner`.

## La pile

| Rôle | Choix |
|---|---|
| UI | Flutter 3.47 (stable), Material 3, `go_router` + `go_router_builder` |
| État | Riverpod 3 avec `riverpod_generator` (les « pods ») |
| Données | Isar 3 via le fork `isar_community` 3.3 — base locale, un fichier par machine, dans `%APPDATA%\com.saroc\marathondujeu` |
| Modèles immuables | `freezed` |
| Localisation | `flutter_localizations`, ARB fr/en, générée par `flutter: generate: true` |
| Cartes / impression | `pdf`, `printing`, `pretty_qr_code`, `flutter_barcode_listener` |

### Arborescence `lib/`

| Dossier | Contenu |
|---|---|
| `src/data/collections/` | les collections Isar (`@collection`) |
| `src/data/repositories/` | accès à la base, un par collection |
| `src/data/models/` | modèles `freezed` hors base (`PlayerCard`, `SearchCriteria`) |
| `src/services/` | logique métier (tirage, cartes, formatage) — sans Flutter UI |
| `src/pods/` | providers Riverpod, générés |
| `src/ui/` | pages, formulaires, widgets de champ |
| `l10n/arb/` | les textes ; `l10n/generated/` est régénéré, ne pas éditer |
| `routes.dart`, `services_injector.dart` | les routes typées et l'injection des services |

## Les commandes

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # après tout changement de collection, pod, freezed ou route
flutter analyze                                             # zéro erreur attendu
flutter test
flutter run -d windows
flutter build windows
```

Les fichiers générés (`*.g.dart`, `*.freezed.dart`, `l10n/generated/`) sont **versionnés** :
après `build_runner`, ils font partie du commit.

## Contraintes d'environnement

- **Le dépôt se travaille depuis un disque local**, sous un chemin court (`C:\Dev\marathondujeu`).
  Flutter pose des liens symboliques vers le cache pub ; un partage réseau les refuse, et un chemin
  long fait échouer MSBuild (limite 260 caractères).
- Isar 3 vient du fork `isar_community` sur pub.dev ; l'original et son hébergeur sont morts.
  `isar_community_generator` 3.3.2 plafonne `analyzer` < 11 : c'est lui qui retient riverpod
  (3.1 / annotation 4.0), freezed (3.2), build_runner (2.15) en deçà de leurs dernières versions.
- Pas de `custom_lint` ni `riverpod_lint` : Dart 3.13 déprécie leur système de plugin et
  `custom_lint` 0.8.1 n'a pas suivi *(retirés le 2026-09-19, L08)*. À remettre quand la chaîne
  le permettra.
- Les tests ouvrent une vraie base Isar dans un dossier temporaire, avec la DLL livrée par
  `isar_community_flutter_libs` (`test/isar_test_support.dart`). Pas de réseau.

## Ce qui est propre à ce projet

- `docs/` accueille les **éléments de définition globaux** de l'application *(acté 2026-09-19)*.
  Il n'en contient aucun pour l'instant : la cible se lit dans le code et dans les lots.
- Identifiant d'organisation : **`com.saroc`** partout *(acté 2026-09-19)*.
- La base des versions antérieures à 2026-09-19 vivait dans `%LOCALAPPDATA%\com.example\marathondujeu` ;
  elle est reprise par copie au premier lancement et laissée en place, sans suppression prévue
  *(acté 2026-09-19)*.
- Les dossiers Android / iOS / macOS / Linux / web restent dans le dépôt **volontairement**, bien
  que seule la cible Windows soit construite *(acté 2026-09-19)*.
- **Public non technique** : les utilisateurs de l'application ne sont pas des informaticiens.
  Chaque écran s'explique — légendes, textes d'aide, zone tutoriel par page *(acté 2026-09-19)*.
- Ce qui sera acté ensuite s'écrira ici, daté.
