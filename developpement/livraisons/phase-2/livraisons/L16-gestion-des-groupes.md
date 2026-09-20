# L16 — Gestion des groupes : catégories, suppression, retrait, ajout par numéro

Statut : **livré** le 2026-09-20 (ouvert le 2026-09-19) · Ne dépend d'aucun lot. Partage un composant avec
L13 (la carte « bille + Retirer ») : **L13 est livré le 2026-09-19 et l'a créé** —
`PlayerBubble` et `RemovableBubble` dans `lib/src/ui/widgets/player_bubble.dart` (*Retirer* en
rouge, poubelle) ; ce lot les reprend.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Les groupes servent aux tirages (joueurs exclus / requis) et, depuis L06, reçoivent les gagnants
de chaque tirage. Aujourd'hui on ne peut ni supprimer un groupe, ni en retirer un joueur, ni
distinguer un groupe fait main d'un groupe de gagnants — et les groupes de gagnants s'empilent
dans la liste. Le lot met de l'ordre (Bastien, 2026-09-19, sur le relevé `docs/gestes.md`).

### Terminologie

- **Catégorie** d'un groupe : *manuel* (fait par l'organisateur) ou *gagnants* (créé par un
  tirage). Un groupe a une catégorie, jamais deux.
- **Mode suppression** : sur la page d'un groupe, l'état où chaque bille devient une carte avec
  un bouton *Retirer* — même forme que sur la page d'une session (L13).

## État du code (constats 2026-09-19)

- `PlayerGroup` : `name`, `players`, `event`. Rien d'autre.
- Liste des groupes : nom et initiales ; « + » ouvre l'éditeur (un nom). **Rien n'ouvre
  l'éditeur d'un groupe existant** : `editPlayerGroup` existe dans le pod, personne ne l'appelle
  (constat corrigé le 2026-09-20 ; le tiroir, lui, laisse `allowRemove` à `true`).
- Page d'un groupe : billes des membres ; l'ajout se fait **par scan seulement** ; aucun retrait.
- `DrawService.calculateDraw` crée le groupe « Gagnants du tirage « … » » et le lie au tirage
  (`Draw.winnersGroup`). Le sélecteur de groupes des tirages montre tous les groupes.

## Périmètre

| Cible | Détail |
|---|---|
| `PlayerGroup` | **`kind`** : `manual` \| `winners` (C1), temps 1 du § 12 ; les groupes existants sont *manual*, sauf ceux liés à un tirage par `winnersGroup` → *winners*, posés à l'ouverture de la base (C2) |
| Liste des groupes | n'affiche que les groupes **manuels** ; les groupes de gagnants n'y figurent pas (Q1) — on les voit dans le tirage qui les a créés (ses gagnants, déjà affichés) et dans le sélecteur des tirages (C5) ; sur chaque ligne, un crayon ouvre l'éditeur du groupe (C8) et une poubelle le supprime (recette, 2026-09-20) |
| Supprimer un groupe (GR-7) | poubelle sur la ligne de la liste, ou bouton *Supprimer* dans l'éditeur ; confirmation ; **refusé tant qu'un tirage l'utilise** (Q2) ; un groupe de gagnants **ne se supprime pas** — il appartient à son tirage (C3) |
| Page d'un groupe | **mode suppression** (interrupteur) : les billes deviennent des cartes bille + *Retirer* (GR-6) ; un champ **« Ajouter par numéro »** + Entrée ajoute le joueur de ce numéro (C4) ; le scan continue d'ajouter ; un crayon dans la barre ouvre l'éditeur (C8) |
| Sélecteur de groupes (tirages) | les deux catégories, les gagnants **marqués** (icône trophée) pour qu'on les reconnaisse en excluant (C5) |
| Textes | fr/en |
| `docs/gestes.md` | GR-3, GR-5 à GR-8 revus, GR-10 et GR-11 ajoutés, TI-4 complété, dans le même commit |

### Hors périmètre

- Ce que fait un scan sur les pages de groupes (L15 : liste → fiche joueur ; page d'un groupe →
  ajout).
- Renommer un groupe de gagnants : il porte le nom de son tirage.
- Des catégories libres (étiquettes saisies) : deux valeurs fixes suffisent au besoin.

## Critère de fin

1. Événement avec trois groupes manuels et deux tirages effectués : la liste montre trois
   groupes, pas les deux groupes de gagnants ; le sélecteur d'un tirage montre les cinq.
2. Ouvrir un groupe manuel qu'aucun tirage n'utilise, *Supprimer*, confirmer : il disparaît.
   Un groupe manuel utilisé par un tirage : *Supprimer* grisé, avec la raison (« Utilisé par
   n tirages »). Un groupe de gagnants ouvert n'a pas de *Supprimer*.
3. Page d'un groupe, mode suppression : *Retirer* le 12 → il n'y est plus ; quitter le mode :
   billes. Taper 37 puis Entrée dans « Ajouter par numéro » : le 37 apparaît ; numéro inconnu →
   « Numéro 37 inconnu » en rouge (même forme que la page d'une session) ; déjà membre → « Déjà
   dans le groupe ».
4. Éditeur de tirage : le sélecteur des groupes montre les gagnants avec leur icône.
5. Base 2025 : ses groupes sont manuels, ceux des tirages sont gagnants — vérifié sur une copie
   de la base réelle, comme en L05.
6. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-20** : 6 — analyse propre, 59 tests verts, build Windows passé. 1 à 5 —
recette faite par Bastien sur le poste (`recettes/recette-L16.md`), livraison demandée sans
réserve ; la migration (5) joue à l'ouverture, le test `migration` couvre le cas d'un groupe
tenu par `winnersGroup`.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 et Q2 tranchées le 2026-09-20.

## Choix d'implémentation

- **C1 — `kind` est une énumération Isar** (`@enumerated`), deux valeurs. Pas de booléen
  `isWinners` : une troisième catégorie viendra peut-être.
- **C2 — Migration à l'ouverture** (`IsarClient`, comme `Player.number`) : les groupes
  référencés par un `Draw.winnersGroup` passent en *winners*, une fois ; les autres restent
  *manual* (valeur par défaut). Testé sur base.
- **C3 — Un groupe de gagnants n'a pas de bouton *Supprimer*** : il est la trace d'un tirage,
  et le tirage ne se supprime plus (L06). Un groupe manuel **utilisé par un tirage** — préparé
  ou effectué, dans ses groupes exclus ou requis — a son *Supprimer* grisé, avec la raison (Q2) :
  un tirage effectué garde ses contraintes lisibles (L06), on ne lui retire pas un groupe.
- **C4 — « Ajouter par numéro »** cherche par le **numéro** (`Player.number`), pas par le code
  de la carte, **dans la liste des joueurs déjà chargée** — comme le champ *Numéro* de la page
  d'une session (L13), sans méthode de service. Le champ se vide après ajout ; numéro inconnu et
  déjà membre s'écrivent en rouge à côté du champ.
- **C5 — Le sélecteur de groupes garde les deux catégories** : exclure les gagnants d'un tirage
  précédent est l'usage premier des groupes de gagnants.
- **C6 — Composant partagé** avec L13 : une carte « bille + *Retirer* » (`RemovableBubble`), et
  le même interrupteur de mode (rouge allumé). **Créés par L13**, ce lot les reprend tels quels.
- **C7 — Tests** : migration, ajout / retrait d'un joueur d'un groupe (service), compte des
  tirages qui utilisent un groupe ; les pages se constatent à la recette.
- **C8 — L'éditeur d'un groupe existant s'ouvre par un crayon** : sur la ligne de la liste et
  dans la barre de la page du groupe. Le clic sur la ligne continue d'ouvrir la page. Supprimer
  le groupe depuis sa page ramène à la liste.
- **C9 — Le champ « Ajouter par numéro » rend la main à la douchette** comme le champ *Numéro*
  de la page d'une session (L13) : deux secondes sans saisie, ou une saisie qui n'est pas un
  nombre. La logique est **recopiée** de la page de session, pas partagée — voir Suggestions.
- **C10 — Une seule modale de suppression** (`deletePlayerGroup`, dans `widgets/`), appelée
  par la liste et par l'éditeur : elle compte les tirages, refuse ou confirme, supprime.
- **C11 — `SelectedPlayerGroup` notifie à chaque lecture** (`updateShouldNotify` → `true`).
  Deux lectures d'un même groupe sont égales par identifiant : Riverpod taisait donc les
  changements de la base, et un membre retiré restait affiché (constaté à la recette). La page
  de session ne souffre pas du même mal parce que l'horloge la redessine chaque seconde —
  `SelectedSession` a le même défaut latent, hors périmètre, signalé en Suggestions.

## Questions tranchées

- **Catégoriser, mettre les gagnants à part, supprimer, retirer, ajouter par numéro** —
  *(Bastien, 2026-09-19)*.
- **Q1 — Les groupes de gagnants : cachés, ou à part ?** → **(b) cachés de la liste**, visibles
  depuis leur tirage et dans le sélecteur des tirages *(Bastien, 2026-09-20)*.
- **Q2 — Supprimer un groupe utilisé par un tirage ?** → **(b) refusé** tant qu'un tirage
  l'utilise *(Bastien, 2026-09-20)*.

## Suggestions

- **Créer un groupe depuis une sélection** (cocher des joueurs dans la liste des joueurs, « en
  faire un groupe ») : plus rapide que le scan ou le numéro un par un. Hors périmètre.
- **Un champ « numéro » partagé** entre la page d'une session et celle d'un groupe : la logique
  de rendu du focus à la douchette (C9) existe maintenant en deux exemplaires. À extraire quand
  un troisième usage arrivera, ou en L15 qui retouche le scan de toutes les pages.
- **`SelectedSession` et `SelectedEvent`** portent le défaut de C11 (égalité par identifiant,
  pas de notification) ; masqué aujourd'hui par l'horloge et par les rebuilds voisins. À corriger
  au même endroit quand un écran statique en dépendra.
- **Les pods `selectedPlayerGroup` / `playerGroups` sans identifiant** font `yield null` puis
  déréférencent `id!` : une erreur de flux dès que l'identifiant manque. Antérieur au lot, pas
  touché.
