# L13 — Affichage des sessions : la page d'une session, puis la liste

Statut : **livré** le 2026-09-19 (ouvert le 2026-09-19) · Ne dépend d'aucun lot. L15 (retour de scan) touche
la même page : livrer L15 d'abord, ou l'un après l'autre sans se marcher dessus — le retour de
scan est dans la barre, pas dans le corps de la page.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

La page d'une session est l'écran de la salle pendant l'événement : c'est là qu'on badge, à
heure fixe, sous pression. Elle doit dire d'un coup d'œil **où on en est** — quelle session,
ouverte ou non, combien de présents — et permettre de **corriger** un badgeage sans passer par la
fiche joueur (Bastien, 2026-09-19). La liste des sessions vient ensuite.

### Terminologie

- **Présent** : le joueur a badgé cette session (`session.players` le contient).
- **Mode suppression** : l'état de la page où chaque bille devient une carte avec un bouton
  pour retirer le joueur de la session. Même forme que le retrait d'un joueur d'un groupe (L16).

## État du code (constats 2026-09-19)

- `session_page.dart` : une horloge, le bouton *Badgeage manuel*, une grille de billes de 50 px
  (`GridView.extent`), une par joueur de l'événement, verte si présent, grise sinon, portant
  `player.name` — pas `number` (L05). Rien sur la session elle-même. Pas de compte, pas de
  légende, pas de recherche.
- `session_list_page.dart` : cartes de 150 px — numéro dans une bille, début / fin, nombre de
  joueurs ; ouverte en `primaryContainer`, passée en `grey.shade400`, à venir en blanc ; pas de
  légende ; l'horloge en haut.
- Dé-badger n'existe que dans la fiche joueur (L11, JO-10). `Session.players.remove` +
  `save` suffit côté données.

## Périmètre

| Cible | Détail |
|---|---|
| **En-tête de la page d'une session** | à gauche : numéro, heure de début et de fin, état **Ouverte / Passée** — rien pour une session à venir (C1) ; au milieu : interrupteur *Badgeage manuel*, champ *Numéro* + bouton *Ajouter* (C10), interrupteur *Mode suppression* (C3) ; à droite : l'horloge. Pas de compteur : le titre de la zone *Présents* le porte (Q2) |
| **Deux zones de billes** (Q3) | **Présents** puis **Absents**, chacune titrée avec son compte, billes avec le **numéro** (`number`) triées par numéro. *Absent* = a badgé au moins une autre session. **Jamais badgé = pas affiché** ; une ligne d'aide le dit (C8) |
| **Animation au badgeage** (Q3) | la bille fait un **pop out** dans *Absents* puis un **pop in** dans *Présents* ; premier badgeage → pop in direct (C9) |
| **Mode suppression** | chaque bille présente devient une **carte** : bille + bouton *Retirer* (C3) ; les absents restent des billes |
| **Retirer un joueur** (SE-6) | en mode suppression, *Retirer* → le joueur n'est plus présent, écrit tout de suite (C4) |
| **Badger sans carte** | un champ *Numéro* + bouton *Ajouter* (Entrée aussi) : badge le joueur de ce numéro sur cette session (C10) ; numéro inconnu → « Numéro n inconnu » |
| **Légende** | les titres des zones remplacent la légende présent / absent ; une ligne pour le mode suppression, une pour « jamais badgé » |
| **Liste des sessions** | légende des trois couleurs, la couleur seule signale la session ouverte ; le compteur reste le nombre de présents (Q2) (C6) |
| Textes | fr/en |
| `docs/gestes.md` | SE-1, SE-3, SE-6 mis à jour, SE-8 à SE-10 ajoutés, dans le même commit |

### Hors périmètre

- Ce que fait un scan sur ces pages, et son retour : L15.
- Ouvrir une session « à la main » hors horaire : c'est le badgeage manuel, voulu tel quel
  *(Bastien, 2026-09-19)*.
- Générer ou supprimer les sessions : formulaire d'événement (EV-8).
- Trier ou filtrer la grille autrement que par numéro.

## Critère de fin

1. Page d'une session ouverte, 200 joueurs dont 42 présents et 17 ayant badgé ailleurs :
   l'en-tête dit « Session 7 — 14:00 à 14:15 — Ouverte » à gauche, l'horloge tourne à droite ;
   la zone *Présents (42)* puis la zone *Absents (17)* ; les 141 autres n'apparaissent pas.
   Session à venir : « Session 7 — 14:00 à 14:15 », sans état.
2. Taper 137 dans *Numéro* puis Entrée ou *Ajouter* : le 137 est badgé, le champ se vide ;
   999 → « Numéro 999 inconnu ». Session à venir, badgeage manuel
   éteint : champ et *Ajouter* grisés. Mode suppression : le bouton dit *Supprimer*,
   Entrée retire le 137.
3. *Mode suppression* : les 42 présents deviennent des cartes avec *Retirer* ; retirer le 137 →
   41 présents, la fiche du 137 le montre absent de cette session, la liste des sessions compte
   41. Quitter le mode : billes.
4. Session passée : en-tête « Passée », tout le reste identique (le badgeage manuel reste
   possible — L15 dit ce que fait un scan).
5. Liste des sessions : légende visible ; la session ouverte se repère sans lire les heures.
6. Scanner un absent : sa bille rétrécit et disparaît de *Absents*, puis grossit dans
   *Présents*. Scanner un joueur jamais badgé : sa bille grossit dans *Présents*.
7. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-19** : 7 — analyse propre, 39 tests verts (deux nouveaux sur
`removePlayerFromSession`), build Windows passe. 1 à 6 : constatés en recette par Bastien
(« L13 bon »), après les retouches de recette consignées en C9, C10 et dans la question
tranchée « En-tête ».

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2 tranchées le 2026-09-19.

## Choix d'implémentation

- **C1 — L'état se lit sur l'horloge du poste** (`Session.isOpenAt(now)`, `endTime` passé) et se
  rafraîchit avec `clockPod`, comme la couleur des cartes de la liste.
- **C2 — Compteur de présents** depuis `session.players.length` — le lien est déjà chargé pour
  les zones.
- **C3 — Mode suppression = un `Switch` dans l'en-tête**, éteint à l'arrivée, **rouge** allumé, comme le bouton *Supprimer* (poubelle) ; en mode
  suppression, les présents sont des `Card` (bille + `Retirer`), les absents des billes. Même
  composant que L16 pour le retrait d'un joueur d'un groupe : `RemovableBubble` ou équivalent,
  partagé.
- **C4 — Retirer écrit tout de suite**, par `EventService.removePlayerFromSession` (à créer, en
  miroir de `forceAddPlayerToSession`), testé sur base. Pas de tampon : on est en salle, la
  fiche joueur (L11) garde son *Enregistrer* pour l'édition posée.
- ~~C5 — La recherche met en évidence~~ : retiré, le champ *Numéro* n'est pas une recherche
  (voir C10 et la question tranchée du 2026-09-19).
- **C6 — La liste ne change pas de forme** : une légende, rien d'autre. Le reste (cartes,
  couleurs, compteur) est bon.
- **C7 — Tests** : `removePlayerFromSession` sur base ; la page se constate à la recette.
- **C8 — « A badgé quelque part » se calcule depuis les sessions de l'événement**
  (`sessionsProvider`, union de leurs `players`), pas depuis `player.sessions` : le flux des
  sessions se rafraîchit à chaque badgeage (la session est réécrite), celui des joueurs non —
  Isar ne surveille pas les liens.
- **C9 — L'animation est locale à la page, détectée au rendu** : chaque rendu compare les
  présents de la session à ceux **du rendu précédent** — pas la nouvelle session à l'ancienne :
  le service ajoute le joueur dans l'objet déjà affiché avant d'écrire, et n'importe quel rendu
  (horloge, « numéro inconnu ») peut tomber entre les deux et montrer le joueur présent d'un
  coup (constaté en recette, deux fois). Une bille qui quitte *Absents* y reste le temps de son
  pop out (gonfle puis rétrécit à rien, `easeInBack`, 300 ms), puis fait son pop in dans
  *Présents* (grossit et rebondit, `elasticOut`, 600 ms). Une bille sans zone de départ fait le
  pop in directement. Rien n'est stocké en base.
- **C10 — Le champ *Numéro* agit** : Entrée ou le bouton badge le joueur de ce numéro
  (`forceAddPlayerToSession`, que la session soit ouverte ou en badgeage manuel — les deux
  seuls cas où le champ et le bouton sont actifs — avec le mode suppression), ou le retire en mode suppression
  (`removePlayerFromSession`, toujours actif). **Le champ rend le focus à la douchette** :
  à Entrée, après deux secondes sans saisie, et dès qu'une saisie n'est pas un nombre — c'est
  un code de douchette qui s'y tape ; le champ se vide, l'écouteur de la douchette fait le
  badgeage comme d'habitude.

## Questions tranchées

- **Dé-badger depuis la page d'une session** → **oui, par un mode de suppression** (cartes avec
  bouton). *(Bastien, 2026-09-19, SE-6)*
- **Bloquer le badgeage sur l'horaire du poste** → **voulu** ; le badgeage manuel ouvre une
  session à la main. *(Bastien, 2026-09-19)*
- **Q1 — Le mode suppression demande-t-il confirmation par joueur ?** → **(a) non**.
  *(Bastien, 2026-09-19)*
- **Q2 — Le compteur de la liste : présents seuls, ou présents / joueurs ?** → **(b) présents
  seuls**, sur la liste comme sur l'en-tête de la page. *(Bastien, 2026-09-19)*
- **Q3 — Deux zones, présents et absents, et une animation au badgeage ?** → **oui** : les
  joueurs jamais badgés sont masqués ; au badgeage, **pop out** de la bille dans *Absents* puis
  **pop in** dans *Présents* (pop in direct au premier badgeage). Le déplacement continu
  d'une zone à l'autre est écarté : il ne montre rien quand la bille de départ est hors écran.
  *(Bastien, 2026-09-19)*
- **En-tête** → titre à gauche, horloge à droite ; ni « À venir » ni compteur ; la liste ne
  porte pas la mention « Ouverte », sa couleur suffit. Le champ *Numéro* **n'est pas une
  recherche mais une saisie pour badger sans carte** : bouton
  *Ajouter* (Entrée aussi), actif si la session est ouverte ou le badgeage manuel allumé ;
  en mode suppression il devient *Supprimer*. *(Bastien, 2026-09-19)*

## Suggestions

- **Son ou flash** à chaque badgeage réussi sur la page d'une session : la personne à la
  douchette ne regarde pas toujours l'écran.
- ~~Colonne des absents en fin de grille~~ : remplacée par les deux zones de Q3.
