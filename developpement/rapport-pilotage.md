# Rapport de pilotage

Dernière mise à jour : 2026-09-19.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Rédiger, sur demande, le rapport de L07 ou L08 (phase 1) ou de L04, L05, L06 (`lots/`).

## Phases

**Phase 1 — remise en état du dépôt**, ouverte le 2026-09-19. L01, L02, L03 livrés le
2026-09-19 ; L07 et L08 ouverts. Objet et critère d'appartenance dans `developpement/phase-1/README.md`,
livraisons dans `developpement/phase-1/rapport-livraisons.md`.

L04, L05 et L06 ne sont rattachés à aucune phase : leurs rapports naîtront dans `lots/`.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Phase | Statut | Rapport |
|---|---|---|---|---|
| L04 | Liste des gagnants d'un tirage : retour à la ligne et défilement | — | à faire | à rédiger |
| L05 | Génération des cartes joueur paramétrable depuis l'interface | — | à faire | à rédiger |
| L06 | Copier un tirage : reprise du paramétrage, gagnants précédents exclus | — | à faire | à rédiger |
| L07 | Hygiène du code : `analyze` à zéro info | 1 | à faire | à rédiger |
| L08 | Montée de Flutter et des dépendances restées en retard | 1 | à faire | à rédiger |

### Notes pour la rédaction des rapports

Constats à reprendre dans le rapport concerné, puis à effacer d'ici.

**L04** — constaté sur l'édition 2025 : quand un tirage désigne beaucoup de gagnants, la liste ne
revient pas à la ligne et ne défile pas ; la fin est invisible. Dans le code :
`draw_list_page.dart`, le `subtitle` du tuile est un `Row` des gagnants (ligne 91), sans
`Wrap` ni défilement.

**L05** — rendre la génération de cartes autonome, réglée depuis l'interface. Ce qui est demandé
(Bastien, 2026-09-19) :
- cartes par ligne et par page ; orientation portrait / paysage ;
- taille de la carte, le ratio étant **lu depuis l'image fournie** ;
- position et taille du QR code sur la carte ;
- position et taille de police du numéro de carte ;
- générer les cartes du numéro x au numéro y ; le nombre de cartes imprimées est **un multiple
  du nombre de cartes par page** (lignes × cartes par ligne) — pas de feuille incomplète
  *(Bastien, 2026-09-19)*.
Dans le code : `card_generator_page.dart` a tout en dur (cartes 201→304, 4 colonnes × 2, A4
paysage, QR 116 pt en (82, 170), numéro en (10, 10)) ; `PlayerCardService.generatePage` accepte
déjà ces paramètres. `Event` porte déjà `playerCardHeight/Width`, `playerCardBackgroundImage`,
`qrCodeSize`, `qrCodePosX/Y`, `idPosX/Y` — jamais alimentés ni lus (le formulaire d'événement ne
les expose pas). Manquent au modèle : cartes par ligne / par page, orientation, taille de police.
Toucher au schéma `Event` sur une base qui a servi : partie I, § 12.

**L06** — `DrawService.createDrawFromDraw` existe mais n'est branchée nulle part (constat
2026-09-19). Objectif (Bastien, 2026-09-19) : depuis un tirage, en créer un second qui reprend
son paramétrage et exclut ses gagnants. La fonction oublie `requiredPlayers` et `winnerCount`,
et ne sauvegarde pas. Manquent : le bouton dans la liste des tirages, les textes fr/en, la
sauvegarde. Sorti de L02 (L02 Q2).

**L07** — sortir d'`analyze` à zéro `info` (13 le 2026-09-19, après L03) : `Color.red/green/blue`
dépréciés dans `color.service.dart` ; types top-level manquants dans `theme.dart` (7),
`debouncer.service.dart`, `icon_selector.dart` ; `BuildContext` après `await` dans
`datetime_form_field.dart`.

**L08** — `flutter pub outdated` du 2026-09-19. Bloqué par Dart 3.9 (Flutter 3.35) : riverpod
3.4, riverpod_annotation / riverpod_generator 4, freezed 4, riverpod_lint 3.1, isar_community
3.3.2, build_runner 2.16. Atteignable sans monter Flutter, mais en majeure : go_router 17,
google_fonts 8, file_picker 11. Mineures sans risque : pdf 3.12, printing 5.14.3,
pretty_qr_code 3.6, uuid 4.6, build_runner 2.7. Ordre proposé : monter Flutter d'abord, puis
`flutter pub upgrade --major-versions` en une fois, avec la recette de L03 (parcours des écrans).
Les contraintes `any` du `pubspec.yaml` sont à remplacer par des `^x.y.z` à cette occasion.

## Questions transversales en attente

- **Tests** : 17 tests depuis L02 (tirage, égalité, persistance), sur une vraie base Isar
  temporaire. Défaut appliqué, pas acté : chaque lot ajoute les tests de son périmètre — pas de
  lot « tests » dédié. Prochain candidat : le calcul de mise en page des cartes (L05).
