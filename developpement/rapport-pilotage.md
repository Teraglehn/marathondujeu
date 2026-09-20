# Rapport de pilotage

Dernière mise à jour : 2026-09-20.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Tous les lots de la phase ont leur rapport. L15, L19 et L18 livrés le 2026-09-20. Reste **L12**
(aide et tutoriels), en dernier, après tout le retravail (Bastien, 2026-09-19).
Question ouverte : L12 Q2 — défaut proposé. L09 (sauvegarde) hors phase, rapport sur demande.

## Phases

**Phase 1 — remise en état du dépôt** : close le 2026-09-19, figée dans
`developpement/livraisons/phase-1/`.

**Phase 2 — besoins de l'édition à venir**, ouverte le 2026-09-19 : L12 ; L04, L05, L06, L10, L11 et L13
livrés le 2026-09-19, L14, L17, L16, L15, L19 et L18 le 2026-09-20. Objet et critère d'appartenance dans `developpement/phase-2/README.md`.

L09 n'est rattaché à aucune phase : son rapport naîtra dans `lots/`.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Phase | Statut | Rapport |
|---|---|---|---|---|
| L09 | Fichier de sauvegarde par événement : export automatique, import dans la liste | — | à faire | à rédiger |
| L12 | Aide et tutoriels : bouton « i » en haut à droite de chaque page, explications dans les écrans | 2 | à faire | `phase-2/L12-aide-et-tutoriels.md` |

### Notes pour la rédaction des rapports

Constats à reprendre dans le rapport concerné, puis à effacer d'ici.

**L09** — fichier de sauvegarde par événement (Bastien, 2026-09-19) :
- **un fichier par événement**, à un emplacement **choisi par l'utilisateur** pour chaque
  événement ;
- **mis à jour automatiquement** : toute modification en base le réécrit, avec un *debounce*
  (regrouper les écritures rapprochées) ;
- il **contient tout l'événement** : ses données et tout ce qui s'y rattache (joueurs, sessions,
  badgeages, groupes, tirages, gagnants) **et l'image de fond des cartes** ;
- il doit pouvoir être **ouvert** : depuis un fichier, **ajouter l'événement à la liste** de la
  base courante (import) — restauration ou transfert vers un autre poste.
À trancher au rapport : format (JSON + image encodée, ou archive), comportement si l'événement
existe déjà en base (remplacer / dupliquer / refuser), déclencheur du debounce (délai), et où
mémoriser l'emplacement choisi (champ sur `Event` → schéma, partie I, § 12).
Dans le code : `Debouncer` existe (`debouncer.service.dart`) ; les dépôts passent tous par
`RepositoryBase.save/delete` — point d'accroche naturel pour « toute modification » ; `Event`
porte déjà `playerCardBackgroundImage` (`List<byte>`).

## Questions transversales en attente

- **`material_ui`** : Flutter 3.47 déplace Material dans le paquet `material_ui` ; les paquets
  tiers y passent (`flex_color_picker` 4, `go_router` 18 le tire déjà). L'application reste sur
  `flutter/material` — leurs types de thème et de localisation diffèrent (constaté en L05 :
  sélecteur de couleur rétrogradé). Une migration de l'application est à prévoir, dans un lot
  dédié ; d'ici là, garder les paquets d'interface sur `flutter/material`.

- **Tests** : 82 tests après L18, sur une vraie base Isar temporaire, dont le parcours e2e (`test/e2e/`) ; chaque lot ajoute les
  tests de son périmètre. **Acté 2026-09-19** : les gestes de `docs/gestes.md` sont appairés à
  un tutoriel et à des tests. **Acté 2026-09-20** : les tests unitaires couvrent la logique,
  un parcours e2e (test de widget sur l'application entière) couvre les gestes réels — c'est
  L18, livré : les 72 gestes ont leur test (`docs/gestes.md`, colonne *Test*).
