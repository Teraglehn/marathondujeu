# Rapport de pilotage

Dernière mise à jour : 2026-09-19.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Rédiger le rapport de L12, sur demande — il naît dans `phase-2/`.

## Phases

**Phase 1 — remise en état du dépôt** : close le 2026-09-19, figée dans
`developpement/livraisons/phase-1/`.

**Phase 2 — besoins de l'édition à venir**, ouverte le 2026-09-19 : L12 ; L04, L05, L06, L10 et L11
livrés le 2026-09-19. Objet et critère d'appartenance dans `developpement/phase-2/README.md`.

L09 n'est rattaché à aucune phase : son rapport naîtra dans `lots/`.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Phase | Statut | Rapport |
|---|---|---|---|---|
| L09 | Fichier de sauvegarde par événement : export automatique, import dans la liste | — | à faire | à rédiger |
| L12 | Aide et tutoriels : bouton « i » en haut à droite de chaque page, explications dans les écrans | 2 | à faire | à rédiger |

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

**L12** — l'application est utilisée par des **personnes non techniques** : chaque écran doit
s'expliquer (Bastien, 2026-09-19). Demandé : une **zone tutoriel par page**, ouverte par un bouton
« i » **en haut à droite de la barre du haut**, toujours au même endroit ; et plus largement un
travail sur les explications et l'UX. Première légende posée dans la fiche joueur (L11 :
présent / absent / badgeage manuel). À trancher au rapport : forme de l'aide (panneau latéral,
boîte de dialogue, page), contenu par page, et si l'aide est un texte par page ou un guide
commun.

## Questions transversales en attente

- **`material_ui`** : Flutter 3.47 déplace Material dans le paquet `material_ui` ; les paquets
  tiers y passent (`flex_color_picker` 4, `go_router` 18 le tire déjà). L'application reste sur
  `flutter/material` — leurs types de thème et de localisation diffèrent (constaté en L05 :
  sélecteur de couleur rétrogradé). Une migration de l'application est à prévoir, dans un lot
  dédié ; d'ici là, garder les paquets d'interface sur `flutter/material`.

- **Tests** : 17 tests depuis L02 (tirage, égalité, persistance), sur une vraie base Isar
  temporaire. Défaut appliqué, pas acté : chaque lot ajoute les tests de son périmètre — pas de
  lot « tests » dédié. 37 tests après L06 (tirages : lancement unique, copie, groupes, urne).
