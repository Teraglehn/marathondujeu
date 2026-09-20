# L20 — Icône de l'application

Statut : **livré le 2026-09-20** (rédigé, rattaché à la phase 2, Q1 tranchée, attaqué et livré le 2026-09-20) · Ne dépend
d'aucun lot ouvert. Dernier lot de la phase (Bastien, 2026-09-20).

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Donner à l'application **son icône** : celle du `.exe`, de la barre des tâches et de la fenêtre
sous Windows. Aujourd'hui, c'est l'icône Flutter par défaut. Au passage, les **noms** que Windows
affiche pour le programme (« marathondujeu ») deviennent « Marathon du Jeu ».

### Terminologie

- **Icône de l'application** : l'image du `.exe`, de la fenêtre et de la barre des tâches — pas
  les icônes Material des pages (le rail, les boutons), qui ne bougent pas.
- **Image source** : le PNG carré, grand (1024 × 1024 au moins), d'où l'`.ico` est produit.

## État du code (constats 2026-09-20)

- `windows/runner/resources/app_icon.ico` : l'icône Flutter par défaut, dix tailles de 16 à 256 px.
  `Runner.rc` la référence (`IDI_APP_ICON`) ; c'est la seule chose à remplacer pour l'icône.
- `Runner.rc` porte aussi les textes du programme : `ProductName`, `FileDescription`,
  `InternalName` valent « marathondujeu » ; `CompanyName` « com.saroc » ;
  `OriginalFilename` « marathondujeu.exe ». Le titre de la fenêtre est
  `L"marathondujeu"` dans `main.cpp` ; l'application le remplace par `app_title` (« Marathon du
  Jeu ») une fois Flutter lancé, mais le premier instant l'affiche tel quel.
- Aucun dossier `assets/` dans le dépôt, aucune image versionnée hors la police. Pas de
  `flutter_launcher_icons`.
- Les dossiers Android / iOS / macOS / Linux / web restent dans le dépôt volontairement
  (`CLAUDE.md`), sans être construits : leurs icônes ne sont pas dans le périmètre.

## Périmètre

| Cible | Détail |
|---|---|
| `tool/app_icon.dart` | le dessin de l'icône, en code (`CustomPainter`) : la source, versionnée, modifiable (Q1) |
| `tool/render_app_icon_test.dart` | rend le dessin en PNG (1024 px, `assets/icon/app_icon.png`) et en `.ico` multi-tailles, d'une commande (C1) |
| `windows/runner/resources/app_icon.ico` | produit par ce rendu ; versionné, comme les autres fichiers générés |
| `windows/runner/Runner.rc` | `ProductName`, `FileDescription`, `InternalName` → « Marathon du Jeu » ; `OriginalFilename` inchangé (le nom du fichier ne bouge pas) ; `LegalCopyright` → l'année en cours (C2) |
| `windows/runner/main.cpp` | le titre de la fenêtre à la création : « Marathon du Jeu » (C3) |
| `docs/gestes.md` | pas de geste : rien à faire, rien à tester à l'écran — une ligne dans *Ce que ce relevé montre* dit que l'icône et les noms se constatent à la recette |

### Hors périmètre

- Les icônes Android, iOS, macOS, Linux, web : cibles non construites.
- Un écran de démarrage (*splash*), une image dans la page du guide ou un logo dans l'application :
  pas demandé.
- Un installateur, une signature du `.exe` : autre lot, si un jour.

## Critère de fin

1. Dans l'Explorateur, `marathondujeu.exe` (`build\windows\x64\runner\Release\`) montre la nouvelle
   icône, à toutes les tailles d'affichage (petites icônes, grandes icônes).
2. Lancée, l'application a cette icône dans la barre des tâches et en haut à gauche de la
   fenêtre ; le titre est « Marathon du Jeu » dès le premier instant.
3. Propriétés du `.exe` → Détails : « Marathon du Jeu » en nom du produit et description.
4. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-20** : 1. l'icône extraite du `.exe` construit est la nouvelle (dé et pion),
l'`.ico` porte sept tailles de 16 à 256 px ; 2. et 3. `VersionInfo` du `.exe` : « Marathon du Jeu »
en nom du produit et description, titre natif « Marathon du Jeu » ; la barre des tâches se voit à
la recette (Bastien, 2026-09-20 : « l'icône est good ») ; 4. analyse propre, 92 tests verts, build
passé.

## Questions déterminantes

Aucune — Q1 tranchée le 2026-09-20.

## Questions non déterminantes

Aucune.

## Choix d'implémentation

- **C1 — Le rendu se fait avec Flutter lui-même, sans dépendance** : `flutter test
  tool/render_app_icon_test.dart` peint l'icône avec `dart:ui` aux tailles 16, 24, 32, 48, 64, 128
  et 256 px et écrit l'`.ico` (des entrées PNG, ce que Windows lit depuis Vista) et le PNG source.
  Écarté : `flutter_launcher_icons`, une dépendance de plus dans une chaîne déjà contrainte
  (`analyzer` < 11), pour un format qui tient en trente lignes.
- **C2 — Les noms de `Runner.rc`** : « Marathon du Jeu » partout où Windows affiche un nom
  lisible ; le nom de fichier et l'identifiant interne du binaire ne changent pas — rien ne les
  référence, mais rien n'y gagne non plus.
- **C3 — Le titre de fenêtre natif** vaut le titre Flutter : le même texte aux deux endroits,
  pour que rien ne clignote au lancement.

## Questions tranchées

- **Q1 — Quelle image ?** → **Claude la dessine**, simple : un **dé à six faces** et une **pièce
  d'échecs**. Il n'existe aucun logo. Le dessin est du code, à retoucher à la recette.
  *(Bastien, 2026-09-20)*

## Suggestions

- Si l'image de Q1 est aussi l'image de fond des cartes ou l'affiche, la reprendre dans le
  **guide** (temps 1) à la place de la ligne d'exemple : une identité visible dès l'aide.
