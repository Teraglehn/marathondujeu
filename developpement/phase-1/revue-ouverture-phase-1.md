# Revue d'ouverture — phase 1

Faite le 2026-09-18, sur le dépôt tel que laissé après l'édition 2025 (dernier commit `0aadadd`).

## Constats

| Contrôle | Résultat |
|---|---|
| `flutter doctor` | tout vert — Flutter 3.35.4 stable, VS 2022, Android SDK |
| `flutter pub get` | résout, mais uniquement grâce au cache pub local (→ L01) |
| `flutter analyze` | 0 erreur, 9 warnings, 30 infos (→ L03) |
| `build_runner build` | sortie identique aux fichiers générés versionnés |
| `flutter test` | 1 test, celui du gabarit Flutter ; il échoue |
| `flutter build windows` | passe depuis `C:\Dev` ; impossible depuis le partage `Z:` |
| Exécution | l'application démarre et tient |

- L'hébergeur d'Isar (`pub.isar-community.dev`) est mort ; le dépôt du fork est archivé (→ L01).
- Trois défauts de code lus dans le modèle et le tirage, et une base ouverte dans un dossier
  purgeable (→ L02).
- `analyzer` épinglé `^6.4.1` retient les générateurs (→ L03).

## Questions ouvertes à l'ouverture

- Aucun test dans le projet. Défaut proposé au pilotage : chaque lot ajoute ceux de son périmètre.
- Hors lots, relevé sans décision : `com.example.marathondujeu`, `README.md` et test du gabarit,
  `.vscode/launch.json` d'un autre projet, plateformes non ciblées, absence de `.gitattributes`
  (bruit CRLF à chaque génération).
