# Rapport de pilotage

Dernière mise à jour : 2026-09-19.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

Rédiger le rapport de L05, L06, L10 ou L11, sur demande — ils naissent dans `phase-2/`.

## Phases

**Phase 1 — remise en état du dépôt** : close le 2026-09-19, figée dans
`developpement/livraisons/phase-1/`.

**Phase 2 — besoins de l'édition à venir**, ouverte le 2026-09-19 : L05, L06, L10, L11 ; L04 livré le 2026-09-19. Objet et critère
d'appartenance dans `developpement/phase-2/README.md`.

L09 n'est rattaché à aucune phase : son rapport naîtra dans `lots/`.

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Phase | Statut | Rapport |
|---|---|---|---|---|
| L05 | Génération des cartes joueur paramétrable depuis l'interface | 2 | à faire | à rédiger |
| L06 | Copier un tirage : reprise du paramétrage, gagnants précédents exclus | 2 | à faire | à rédiger |
| L09 | Fichier de sauvegarde par événement : export automatique, import dans la liste | — | à faire | à rédiger |
| L10 | Bonus d'un joueur : boutons « + » et « − » dans la liste des joueurs et dans l'éditeur latéral | 2 | à faire | à rédiger |
| L11 | Fiche joueur (éditeur latéral) : QR code, sessions badgées / non badgées, badgeage manuel | 2 | à faire | à rédiger |

### Notes pour la rédaction des rapports

Constats à reprendre dans le rapport concerné, puis à effacer d'ici.

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

**L10** — un « + » et un « − » sur le bonus d'un joueur, **à deux endroits** : la ligne *Bonus* de
chaque carte de la liste des joueurs, et l'éditeur latéral du joueur (`player_edit_form.dart`,
en plus ou à la place du champ texte) (Bastien, 2026-09-19).
Dans le code : `player_list_page.dart` a déjà `plusOneBonus(player)` (ligne 32, incrémente et
sauvegarde) et un `trailing: IconButton(... Icons.plus_one)` **commenté** sur la tuile *Bonus*
(ligne 131). Le « − » n'existe pas. À trancher : borne basse (0 ? négatif autorisé ?), et si le
bonus doit rester éditable dans le formulaire (`player_edit_form.dart`, champ texte). Le compteur
*jetons* de la carte (`getTokenCount`) doit se rafraîchir dans la foulée.

**L11** — la **fiche joueur** dans l'éditeur latéral (`EditDrawerWidget` → `player_edit_form.dart`)
(Bastien, 2026-09-19) :
- l'**image du QR code** du joueur (celle des cartes : `PlayerCard.getQrImage`, `pretty_qr_code`) ;
- la **liste de toutes les sessions** de l'événement, chacune **verte** si le joueur y a badgé,
  **grisée** sinon ;
- un **mode manuel** : une fois activé, cliquer une session badge (ou dé-badge) le joueur depuis
  l'éditeur — la page session le fait déjà par la douchette (`Session.forceAddPlayer`).
Aujourd'hui le formulaire n'expose que nom, QR code (texte) et bonus. À trancher : le mode
manuel permet-il aussi de retirer un badgeage ; faut-il confirmer ; ordre et présentation des
sessions (numéro + heure de début). `Player.sessions` est un backlink Isar (`load()` avant
affichage) ; le badgeage s'écrit côté `Session.players`.

## Questions transversales en attente

- **Tests** : 17 tests depuis L02 (tirage, égalité, persistance), sur une vraie base Isar
  temporaire. Défaut appliqué, pas acté : chaque lot ajoute les tests de son périmètre — pas de
  lot « tests » dédié. Prochain candidat : le calcul de mise en page des cartes (L05).
