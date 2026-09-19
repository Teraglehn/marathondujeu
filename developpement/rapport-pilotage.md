# Rapport de pilotage

Dernière mise à jour : 2026-09-19.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Rédiger les rapports, un à la fois, sur demande. Ordre proposé : L01, L04, L05, L02, L03 — les
deux lots fonctionnels (L04, L05) sont le besoin de l'édition à venir ; L01 passe devant parce
que tout build futur en dépend.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Statut | Rapport |
|---|---|---|---|
| L01 | Migration Isar → `isar_community` | à faire | à rédiger |
| L02 | Corrections du modèle de données et du tirage | à faire | à rédiger |
| L03 | Montée Riverpod 3, freezed 3, go_router_builder 4 | à faire | à rédiger — dépend de L01 |
| L04 | Liste des gagnants d'un tirage : retour à la ligne et défilement | à faire | à rédiger |
| L05 | Génération des cartes joueur paramétrable depuis l'interface | à faire | à rédiger |

### Notes pour la rédaction des rapports

Constats à reprendre dans le rapport concerné, puis à effacer d'ici.

**L01** — `pub.isar-community.dev` sert une page Nextcloud ; le dépôt GitHub `isar-community/isar`
est archivé (2025-08). La résolution actuelle (`isar` 3.1.8) ne tient que par le cache pub local.
Le fork est republié sur pub.dev : `isar_community`, `isar_community_flutter_libs`,
`isar_community_generator` en 3.3.2, API v3. Une base de l'édition 2025 existe : vérifier la
compatibilité du format de fichier avant de livrer.

**L02** — quatre constats en lecture :
- `Event`, `Draw`, `DrawWinner` : `operator ==` teste `other is Session` (copier-coller) —
  deux instances de même id ne sont jamais égales.
- `DrawService.createDrawFromDraw` construit la copie et ne la sauvegarde pas.
- `DrawService._getPlayerList` : `players = requiredPlayers` puis `removeWhere` mute les
  `IsarLinks` du tirage.
- `IsarClient` ouvre la base dans `getApplicationCacheDirectory()` — un dossier purgeable, pour
  un registre de participants. Un déplacement touche une base qui a servi : partie I, § 12.
Premier test métier candidat : le tirage pondéré (`_getWinner`).

**L03** — `analyzer` est épinglé `^6.4.1` en dev ; c'est ce qui retient les générateurs. Cible :
riverpod 3.x, riverpod_generator 4.x, freezed 3.x, go_router_builder 4.x. Résout aussi les
9 warnings d'`analyze` (`_XxxRef` générés inutilisés, imports inutilisés dans `image_form_field`).

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

## Questions transversales en attente

- **Tests** : aucun test à ce jour (le seul fichier est le gabarit Flutter, qui échoue). Défaut
  proposé : chaque lot ajoute les tests de son périmètre, à commencer par le tirage (L02) et le
  calcul de mise en page des cartes (L05) — pas de lot « tests » dédié.
- Ouvrir une phase 1 maintenant, ou laisser les lots naître dans `lots/` ? Aucune phase n'est
  ouverte ; les gabarits `phase-N/` de l'annexe A ne sont pas posés.
- Hors lots, relevé sans décision : identifiant `com.example.marathondujeu` partout ; `README.md`
  et `test/widget_test.dart` sont ceux du gabarit Flutter ; `.vscode/launch.json` nomme
  « ecopilot » ; plateformes iOS/macOS/Linux/web présentes sans usage. À trier en lots ou à
  écarter.
