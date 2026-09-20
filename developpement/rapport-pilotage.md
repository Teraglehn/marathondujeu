# Rapport de pilotage

Dernière mise à jour : 2026-09-20.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Tous les lots de la phase sont livrés (L15, L19, L18, L12, L12b et L09 le 2026-09-20). **Aucun lot
ouvert** : clore la phase 2, ou y rattacher la suite.

## Phases

**Phase 1 — remise en état du dépôt** : close le 2026-09-19, figée dans
`developpement/livraisons/phase-1/`.

**Phase 2 — besoins de l'édition à venir**, ouverte le 2026-09-19 : aucun lot ouvert ; L04, L05, L06, L10, L11 et L13
livrés le 2026-09-19, L14, L17, L16, L15, L19, L18, L12, L12b et L09 le 2026-09-20. Objet et critère d'appartenance dans `developpement/phase-2/README.md`.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Phase | Statut | Rapport |
|---|---|---|---|---|

### Notes pour la rédaction des rapports

Constats à reprendre dans le rapport concerné, puis à effacer d'ici. Aucune.

## Questions transversales en attente

- **`material_ui`** : Flutter 3.47 déplace Material dans le paquet `material_ui` ; les paquets
  tiers y passent (`flex_color_picker` 4, `go_router` 18 le tire déjà). L'application reste sur
  `flutter/material` — leurs types de thème et de localisation diffèrent (constaté en L05 :
  sélecteur de couleur rétrogradé). Une migration de l'application est à prévoir, dans un lot
  dédié ; d'ici là, garder les paquets d'interface sur `flutter/material`.

- **Tests** : 92 tests après L09, sur une vraie base Isar temporaire, dont le parcours e2e (`test/e2e/`) ; chaque lot ajoute les
  tests de son périmètre. **Acté 2026-09-19** : les gestes de `docs/gestes.md` sont appairés à
  un tutoriel et à des tests. **Acté 2026-09-20** : les tests unitaires couvrent la logique,
  un parcours e2e (test de widget sur l'application entière) couvre les gestes réels — c'est
  L18, livré : les 76 gestes ont leur test (`docs/gestes.md`, colonne *Test*).
