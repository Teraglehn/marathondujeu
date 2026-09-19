# Rapport de pilotage

Dernière mise à jour : 2026-09-19.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Rédiger le rapport de L04, L05 ou L06, sur demande — ils naissent dans `lots/`. Ou rattacher à
la phase 1 un des points « hors lots » ci-dessous.

## Phases

**Phase 1 — remise en état du dépôt**, ouverte le 2026-09-19. L01, L02, L03 livrés le
2026-09-19 ; aucun lot ouvert. Objet et critère d'appartenance dans `developpement/phase-1/README.md`,
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

## Questions transversales en attente

- **Tests** : aucun test à ce jour (le seul fichier est le gabarit Flutter, qui échoue). Défaut
  proposé : chaque lot ajoute les tests de son périmètre, à commencer par le tirage (L02) et le
  calcul de mise en page des cartes (L05) — pas de lot « tests » dédié.
- Hors lots, relevé sans décision : `README.md` est celui du gabarit Flutter ; plateformes
  iOS/macOS/Linux/web présentes sans usage ; pas de `.gitattributes` (bruit CRLF à chaque
  génération). À trier en lots ou à écarter.
