# L09 — Fichier de sauvegarde par événement : export automatique, import dans la liste

Statut : **livré le 2026-09-20** (rédigé, rattaché à la phase 2, Q1 à Q4 tranchées, attaqué et livré le 2026-09-20) · Ne dépend
d'aucun lot ouvert.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Chaque événement peut avoir **un fichier de sauvegarde**, à un emplacement choisi par
l'utilisateur, **réécrit tout seul** à chaque modification en base (avec regroupement des
écritures rapprochées). Il contient **tout l'événement** — ses réglages, l'image de fond des
cartes, joueurs, sessions et badgeages, groupes, tirages et gagnants. Et il **s'ouvre** : depuis
un fichier, l'événement est **ajouté à la liste** de la base courante — pour restaurer après un
poste mort, ou passer l'événement sur un autre poste *(Bastien, 2026-09-19)*.

### Terminologie

- **Fichier de sauvegarde** : le fichier d'un événement, tenu à jour par l'application. Pas
  « export » : on ne le produit pas à la main, il suit.
- **Ouvrir un fichier de sauvegarde** : lire un tel fichier et ajouter son événement à la base.
  Pas « importer » dans les écrans — le mot est technique.
- **Sauvegarde** tout court désigne le fichier, jamais la base Isar.

## État du code (constats 2026-09-20)

- Six collections : `Event`, `Player`, `Session`, `PlayerGroup`, `Draw`, `DrawWinner`. Tout se
  tient par des **liens Isar** (`IsarLink` / `IsarLinks`) : `player.event`, `session.players`,
  `group.players`, `draw.excludedSessions` / `requiredSessions` / `excludedGroups` /
  `requiredGroups` / `excludedPlayers` / `requiredPlayers` / `winnersGroup`, `drawWinner.draw` /
  `winner`. L'export JSON natif d'Isar **ignore les liens** : il faut un format à soi.
- Les identifiants Isar (`id`) sont **propres à chaque base** : un fichier ne peut pas les
  porter. Les joueurs ont un `number` unique dans l'événement, les sessions un `number`, les
  groupes et tirages un nom (pas unique) : le fichier référence par **numéro** ou par **rang dans
  le fichier**.
- Toute écriture passe par `RepositoryBase.save` / `saveAll` / `delete` / `deleteAll` : le point
  d'accroche de « toute modification ». Les dépôts ne connaissent pas tous l'événement touché
  (`DrawWinner` → `Draw` → `Event`).
- `Debouncer` existe (`debouncer.service.dart`, `run(action)` à délai fixe) ; la liste des
  joueurs l'emploie déjà et **retient la fermeture de l'application** le temps d'écrire
  (`AppLifecycleListener.onExitRequested`) — le modèle à reprendre.
- `Event.playerCardBackgroundImage` est un `List<byte>` (PNG réduit à 300 dpi, L05) ; quelques
  centaines de Ko.
- `file_picker` est déjà une dépendance (image de fond) : `saveFile` et `pickFiles` sont là.
- La base sert en production depuis 2025 : tout champ nouveau sur `Event` suit la partie I,
  § 12 de la méthode (**ajouter**, jamais renommer ni retirer).
- Aucun événement ne se supprime aujourd'hui (EV-10 sans effet, `docs/gestes.md`) : un
  événement ajouté deux fois resterait deux fois.

## Périmètre

| Cible | Détail |
|---|---|
| `src/services/backup/backup_format.dart` | le format : un document JSON par événement, version `1` (C1), image en base64 (Q1), références par numéro ou rang (C2) ; `toJson(event…)` et `fromJson` **purs**, sans base |
| `src/services/backup/backup_service.dart` | l'écriture : après toute écriture en base, réécrit le fichier de chaque événement qui en a un, après regroupement (Q3) ; écriture atomique (C3) ; retient la fermeture de l'application (C4). La lecture : ouvre un fichier et **ajoute** l'événement à la base, en une transaction (Q2) |
| `Event.backupPath` | le chemin du fichier de sauvegarde, `String?` — champ **ajouté** (Q4, § 12) |
| `src/services/backup/backup_file_picker.dart` | les deux dialogues du système (où écrire, quel fichier ouvrir), derrière une classe que le parcours e2e remplace (C9) |
| Éditeur d'événement | un bloc **Fichier de sauvegarde** : le chemin ou « Aucun », *Choisir…* (`saveFile`, nom proposé `<nom>.marathon.json`), *Retirer* ; « Dernière sauvegarde à HH:MM:SS » ; en cas d'échec d'écriture, un toast d'erreur (C6) |
| Liste des événements | un bouton **Ouvrir un fichier de sauvegarde** (`pickFiles`) ; l'événement ajouté devient l'événement sélectionné ; toast « Événement « … » ajouté » |
| `docs/gestes.md` | EV-12 choisir / retirer le fichier de sauvegarde, EV-13 ouvrir un fichier ; leurs tests |
| Aide et guide | un pas de plus dans l'aide de la page des événements (le bouton *Ouvrir…*) ; dans le guide, le temps *Créez l'événement* parle de l'aperçu des sessions et du fichier de sauvegarde, illustré par la ligne de l'événement et son fichier (Bastien, 2026-09-20 : dans la section événement, pas un temps de plus) |
| Tests | aller-retour du format sur un événement complet (joueurs, badgeages, groupes, tirages, gagnants, image) ; le service : écriture après regroupement, une seule écriture pour dix modifications rapprochées ; ouverture dans une base vide → mêmes numéros, mêmes badgeages, mêmes gagnants ; le parcours e2e : choisir un fichier dans un dossier temporaire, badger, constater le fichier, vider la base, l'ouvrir |

### Hors périmètre

- Sauvegarder **la base entière** (tous les événements en un fichier) : un fichier par
  événement suffit, c'est l'unité qu'on transporte.
- Un historique de versions du fichier : le fichier est l'état courant, rien d'autre.
- Fusionner un fichier avec un événement existant (badgeages faits sur deux postes) : Q2 tranche
  entre ajouter et remplacer, pas plus.
- Sauvegarde sur un réseau ou un service en ligne : l'utilisateur choisit un dossier, l'outil de
  synchronisation est le sien.

## Critère de fin

1. Un événement avec un fichier choisi : badger un joueur → dans les 5 s, le fichier est réécrit
   et porte ce badgeage (lecture du JSON).
2. Dix modifications en deux secondes → **une** écriture.
3. Fermer l'application pendant le délai → le fichier est écrit avant la fermeture.
4. Sur une base **vide**, ouvrir le fichier → l'événement est là, sélectionné, avec les mêmes
   joueurs (numéros, noms, bonus, codes de carte), sessions (numéros, horaires, présents), groupes
   (noms, membres, catégorie), tirages (réglages, contraintes, gagnants dans l'ordre, date du
   tirage) ; l'image de fond s'affiche dans le générateur.
5. Ouvrir un fichier dont l'événement est déjà en base → le comportement de Q2.
6. Un fichier illisible (pas du JSON, version inconnue, champ manquant) → un toast d'erreur, rien
   n'est écrit en base.
7. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-20** : 1. étape 11 du parcours : un badgeage, le fichier le porte (attente
bouclée, moins de 3 s) ; 2. `backup_service_test` : dix écritures rapprochées, un fichier écrit
une fois ; 3. `flush` à la fermeture (`AppLifecycleListener`), testé sur le service ; 4. base vidée
puis fichier ouvert : 20 joueurs, session 3 avec son présent, même `uid`, chemin absent ; l'image
vérifiée en test de service (aller-retour champ par champ) ; 5. même fichier ouvert deux fois →
modale, *Remplacer*, un seul événement ; 6. « pas du json » → toast, rien d'écrit ; 7. analyse
propre, 92 tests verts, build passé.

## Questions déterminantes

Aucune — Q2 tranchée le 2026-09-20.

## Questions non déterminantes

Aucune — Q1, Q3 et Q4 tranchées le 2026-09-20.

## Choix d'implémentation

- **C1 — Un numéro de version dans le fichier** (`"format": 1`) : une version inconnue est
  refusée avec son numéro ; une version ancienne pourra être lue plus tard.
- **C2 — Références par numéro et par rang** : les joueurs par `number`, les sessions par
  `number`, les groupes et tirages par leur rang dans le tableau du fichier ; les gagnants par
  `position` et numéro de joueur. Aucun `id` Isar dans le fichier.
- **C3 — Écriture atomique** : le JSON s'écrit dans `<fichier>.tmp`, puis remplace le fichier —
  une coupure ne laisse jamais un fichier à moitié écrit.
- **C4 — La fermeture attend l'écriture** : `AppLifecycleListener.onExitRequested` force
  l'écriture en attente, comme la liste des joueurs le fait pour le bonus.
- **C5 — La base prévient, le service décide** : le service écoute les six collections
  (`watchLazy`) — toute écriture, par n'importe quel dépôt, l'appelle, sans rien changer aux
  dépôts ; il réécrit **tous** les événements qui ont un fichier, après le délai.
  *Amendé le 2026-09-20* : le rapport prévoyait un appel depuis `RepositoryBase` ; l'écoute
  d'Isar fait la même chose sans toucher les dépôts. Quelques centaines
  d'objets par événement : sérialiser tout à chaque fois est sans coût perceptible, et évite de
  remonter l'événement depuis chaque collection.
- **C6 — Une erreur d'écriture se voit** (dossier disparu, disque plein) : toast d'erreur avec le
  nom de l'événement ; l'application continue, la base reste la référence.
- **C7 — Le service se teste sans interface** : il prend un `Clock`-like ou un délai injectable
  pour ne pas attendre 2 s réelles.
- **C8 — Le format est lu et écrit par le même code** (`BackupFormat`), et le test d'aller-retour
  compare champ par champ : ce qui n'est pas dans le test n'est pas sauvegardé.
- **C9 — *Choisir…* écrit la première version** : `file_picker` 13 ne rend pas un chemin, il
  écrit des octets là où l'utilisateur le dit et rend l'adresse ; on lui donne l'état courant.
  Le dialogue est derrière `BackupFilePicker`, que le parcours e2e remplace par des chemins
  connus — le dialogue du système reste en recette.
- **C10 — Le chemin s'enregistre tout de suite** sur un événement existant (sans passer par
  *Enregistrer*, et sans compter comme modification en cours) ; sur un événement neuf, il part
  avec le reste à *Enregistrer*.

## Questions tranchées

*(Bastien, 2026-09-20 : « reco partout » — les quatre défauts proposés.)*

- **Q1 — Format du fichier ?** → **un seul fichier JSON**, l'image en base64 dedans. Écarté :
  une archive ZIP (JSON + PNG), une dépendance et deux fois plus de code pour un gain de place
  qui ne compte pas.
- **Q2 — L'événement du fichier existe déjà en base ?** → **un identifiant stable `Event.uid`**
  (UUID, champ ajouté, posé à la création et, pour les événements existants, à la première
  écriture) voyage dans le fichier ; même `uid` en base → modale « Cet événement est déjà là » :
  **Remplacer** (l'événement et tout ce qui s'y rattache sont supprimés puis recréés depuis le
  fichier, en une transaction) ou **Annuler** ; `uid` absent → ajout. Écarté : toujours ajouter
  (sans suppression d'événement, deux copies pour toujours) ; reconnaître par le nom (fragile).
- **Q3 — Délai de regroupement ?** → **2 s** après la dernière écriture, **30 s** au plus en
  activité continue.
- **Q4 — Où mémoriser l'emplacement ?** → **sur `Event`** (`backupPath`, champ ajouté), propre
  au poste : il **ne voyage pas** dans le fichier ; au lancement, un dossier disparu → toast et
  « Aucun ».

## Suggestions

- **Ouvrir aussi par glisser-déposer** un fichier sur la liste des événements (`DropTarget`) —
  après, si le bouton ne suffit pas.
- **Un dossier de sauvegarde par défaut** (`Documents\Marathon du Jeu\`) proposé au premier
  *Choisir…*, pour que personne n'ait à réfléchir à l'emplacement.
- Une fois L09 en place, **EV-10 (supprimer un événement)** devient raisonnable : la sauvegarde
  rend la suppression réversible. À trancher dans son propre lot.
