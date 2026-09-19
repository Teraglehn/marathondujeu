# Marathon du Jeu — gestion des participants

Application **desktop Windows** pour tenir le « Marathon du Jeu », 24 heures de jeu de société.
Les joueurs badgent à heure fixe avec une carte à QR code ; leur présence pèse dans les tirages
au sort. Utilisée sur l'édition 2025.

## Construire

Flutter 3.35 stable. Depuis un disque local, sous un chemin court (`C:\Dev\…`) : un partage
réseau ou un chemin long fait échouer le build.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # après tout changement de collection, pod, freezed ou route
flutter analyze
flutter test
flutter run -d windows
flutter build windows
```

Les fichiers générés sont versionnés.

## Données

Base locale Isar (`isar_community` 3.3), un fichier par machine :
`%APPDATA%\com.saroc\marathondujeu\default.isar`.

## Repères

- `CLAUDE.md` — ce qu'est le projet, la pile, l'arborescence.
- `docs/` — documents de référence, dont la méthode de travail.
- `developpement/` — le suivi : lots, phases, livraisons.
