# L07 — Hygiène du code : `analyze` à zéro info

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Corriger les 13 `info` que `flutter analyze` remonte depuis L03, pour que la commande sorte
propre et que toute nouvelle remontée saute aux yeux. Un seul comportement change (Q1).

## Périmètre

| Fichier | Info | Correction |
|---|---|---|
| `src/services/color.service.dart` (3) | `Color.red/green/blue` dépréciés | `(c.r * 255).round() & 0xff`, idem `g`, `b` — même valeur qu'avant |
| `theme.dart` (7) | type de retour manquant sur `getLightExtensions()` … `getDarkHighContrastExtensions()` et `getExtensions()` | annoter `List<ThemeExtension<dynamic>>` (ou le type exact que retourne `getExtensions`) |
| `src/services/debouncer.service.dart` (1) | type de retour manquant sur `run` | `void run(…)` |
| `src/ui/widgets/fields/icon_selector.dart` (1) | paramètre `icon` non typé dans `itemBuilder` | `IconData icon` |
| `src/ui/widgets/fields/datetime_form_field.dart` (1) | `state.context` utilisé après un `await` | sortir si la date est annulée, puis `if (!state.mounted) return;` avant l'heure (Q1) |

### Hors périmètre

- Toute retouche de comportement ou de style au-delà de la ligne signalée.
- Les fichiers générés (`*.g.dart`, `*.freezed.dart`) : ils ne remontent rien.
- Durcir `analysis_options.yaml` (règles supplémentaires) : pas demandé.

## Critère de fin

1. `flutter analyze` : **`No issues found!`** — 0 erreur, 0 warning, 0 info.
2. `flutter test` : 17 tests verts, inchangés.
3. `flutter build windows` passe.
4. Recette (courte) : le sélecteur de date-heure d'une session ouvre bien la date puis l'heure ;
   la couleur de texte d'un groupe de joueurs reste lisible sur sa couleur de fond
   (`getContrastColor`).

**Constaté le 2026-09-19** :
1. `flutter analyze` : `No issues found!`.
2. `flutter test` : 17 tests verts.
3. `flutter build windows` : construit.
4. Recette : à faire par Bastien (date-heure d'une session, lisibilité des couleurs de groupe).
Écart : `icon_selector.dart` — typer `itemBuilder(IconData icon)` a demandé un `!` sur l'appel
déjà gardé par `state.value != null` (ligne 102).

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 tranchée le 2026-09-19.

## Choix d'implémentation

- **C1 — Une correction par info, rien autour.** Pas de reformatage des fichiers touchés
  (`theme.dart` a 400 lignes d'indentation irrégulière : on n'y touche pas).
- **C2 — Les couleurs gardent leur valeur 0–255.** La formule de luminance qui suit attend cette
  échelle ; on convertit les composantes flottantes plutôt que de réécrire la formule.

## Questions tranchées

- **Q1 — Sélecteur de date-heure : que faire si la date est annulée ?** → **(b) : ne pas ouvrir
  le sélecteur d'heure si la date est annulée.** Seul changement de comportement du lot.
  *(Bastien, 2026-09-19)*

## Suggestions

- Une fois à zéro, brancher `flutter analyze --fatal-infos` dans la commande de vérification
  (méthode, partie I, § 7 : un contrôle plutôt que la vigilance).
