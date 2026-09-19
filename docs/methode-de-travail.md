# Méthode de travail

Dernière mise à jour : 2026-09-19.

Comment on travaille ensemble — Bastien et Claude Code. **Ce document fait foi** : une règle de
méthode s'écrit ici, dans le commit qui la justifie, et nulle part ailleurs à titre principal.

**Qui l'entretient** *(acté 2026-08-21)* : la méthode évolue **à la demande de l'auteur du projet**,
jamais de la seule initiative de Claude. **Claude peut en revanche proposer des mises à jour** — et
doit le faire quand il constate qu'une pratique n'est pas écrite, qu'une règle est devenue fausse ou
qu'une décision de séance mériterait d'entrer ici. Proposer, oui ; modifier, sur demande.
*Déclaré complet le 2026-08-21.*

Il est en **deux parties**. La **partie I** est un **noyau portable** : elle ne cite ni nom de projet,
ni identifiant de lot, ni document de référence particulier — elle se reprend telle quelle d'un dépôt
à l'autre. La **partie II** décrit l'application de ce noyau **à ce dépôt-ci** : c'est la seule partie
qui devient fausse ailleurs. Deux annexes portent les gabarits prêts à poser.

> **Ordre de lecture** : `CLAUDE.md` d'abord (il dit ce qu'est le projet), ce document ensuite (il dit
> comment on y travaille). Avant d'agir, pas après.

---

# Partie I — Noyau portable

## 1. Le rythme : proposer, s'arrêter, attendre

Pour toute tâche non triviale : **proposer un plan court, puis s'arrêter**. Présenter le périmètre,
les points tranchés seul, les écarts constatés — et rendre la main.

On ne reprend que sur un mot explicite : « vas-y », « valide », « fais-le ».

**Répondre à des questions de cadrage n'est pas un feu vert.** Tant que le mot n'est pas dit, le plan
reste un plan — y compris pour de la documentation, y compris quand toutes les questions ont reçu
leur réponse.

Quand la demande est ambiguë : **demander**. Nommer ce qui n'est pas clair plutôt que choisir une
interprétation en silence.

> **Pourquoi** : un plan validé coûte une minute ; un travail parti sur la mauvaise interprétation
> coûte la séance. Et le coût est asymétrique — c'est celui qui relit qui paie.

### Le compte rendu d'une implémentation

Le message qui clôt un travail **ne porte que les écarts et les doutes** : ce qui a dévié du plan,
ce qui a été tranché en cours de route sans demande, ce qui reste incertain. Ce qui s'est passé
comme prévu n'y figure pas — le contrôle qui passe, la suite verte, les gestes annoncés puis faits.

Les **constats du critère de fin** appartiennent au rapport, pas au message : c'est là qu'un critère
se constate par écrit.

Et **pas d'état du working tree** hors demande : ni tableau des fichiers touchés, ni `git status`
recopié. Une ligne sur ce qui a bougé suffit.

> **Pourquoi** : un compte rendu qui déroule le prévu noie le seul contenu utile. Le prévu se lit
> dans le rapport et dans le contrôle qui passe.

## 2. Git : l'historique appartient à l'auteur du projet

**Jamais `commit` ni `push` sans autorisation explicite.** Préparer les modifications dans le working
tree, les présenter, attendre.

**Le message de commit se rédige quand le commit est demandé**, pas à la fin de chaque travail. Un
travail présenté n'appelle pas son message : le proposer d'office pousse vers un geste qui n'a pas
été demandé. Demander de livrer vaut demander le commit — la livraison l'inclut —, et vaut recette
faite (§ 10).

**Un mot fait exception : « livre ».** Il vaut autorisation de commit **pour le périmètre de la
livraison et rien d'autre** — migrer le rapport du lot, mettre à jour le rapport de pilotage et le
rapport de livraisons de la phase, committer le tout. Ni push, ni geste supplémentaire.

**La livraison commence par la vérification finale** *(acté 2026-08-22)* : les suites complètes
(vérification, bout en bout) se jouent en premier — d'autant plus qu'elles ont été allégées
pendant la recette (§ 10). Un échec, ou un constat qui demande un arbitrage, **suspend la
livraison** : le problème est présenté, la main rendue — on ne livre pas par-dessus un doute.

La règle « la documentation et le code qu'elle justifie vont dans le même commit » porte sur le
**contenu** du commit, jamais sur l'autorisation de le créer.

> **Pourquoi** : quand les commits vont directement sur la branche principale, un commit non sollicité
> est difficile à rattraper.

## 3. Les rapports de lot

**Un rapport ne se rédige que sur demande explicite.** Jamais en avance, jamais de sa propre
initiative, même quand la liste des lots est validée. L'auteur du projet peut en demander
plusieurs d'un coup : sa demande vaut pour chacun.

**La demande d'un rapport vaut « vas-y » pour ce rapport** *(acté 2026-09-19)* : le fichier se
crée directement, sans plan préalable ni arrêt. Le § 1 s'applique au code, pas au rapport —
qui est lui-même la proposition.

> **Pourquoi** : les arbitrages à venir invalident les hypothèses des rapports lointains. Une
> prévision détaillée sur des décisions non prises est du travail à refaire — et de la lecture
> imposée pour rien. La liste courte tient le cap ; le détail vient au moment d'attaquer.

**Un rapport est autoportant** : on doit pouvoir attaquer un lot en ne lisant que son rapport.

### Structure

| Section | Contenu |
|---|---|
| **Objet** | la tâche, en une ou deux phrases |
| **Périmètre** / **Hors périmètre** | ce qui est fait, et ce qui est volontairement écarté |
| **Critère de fin** | cible vérifiable — pas « ça marche », mais quoi observer |
| **Questions déterminantes** | sans réponse, le lot ne démarre pas ou l'architecture serait à refaire |
| **Questions non déterminantes** | plusieurs options réelles ; une réponse par défaut est proposée, on avance sans attendre |
| **Choix d'implémentation** | décisions d'exécution sans alternative sérieuse : affirmées, pas posées en question |
| **Questions tranchées** | arbitrées, avec leur date et leur source |
| **Suggestions** | ce qui est proposé sans avoir été demandé |

### Numérotation

- **Une seule séquence Q1, Q2, … par rapport**, toutes sections confondues.
- **Un numéro n'est jamais réattribué.** Une question garde le sien en changeant de section.
- Les renvois entre lots citent le lot et le numéro : « Lnn Qn ».
- **Q est réservé aux vraies questions.** Une question suppose **plusieurs options réelles**. Ce qui
  n'a qu'une option sérieuse est affirmé en **Choix d'implémentation**, étiqueté **C1, C2, …** —
  séquence distincte. Ce qui découle d'une décision déjà prise descend directement en **Questions
  tranchées**, avec sa source, en gardant son numéro Q.
- Un choix étiqueté Q à tort **passe en C** : son numéro Q est retiré, jamais réattribué.
- Une question tranchée **descend**, elle n'est pas supprimée : l'historique des arbitrages fait
  partie du suivi.

> **Pourquoi** : les réponses arrivent par référence — « Q3 : oui ». Un doublon rend la référence
> ambiguë, et un numéro recyclé rend un renvoi ancien faux sans prévenir.

### Le rapport suit l'échange

**Une question tranchée en conversation s'écrit dans son rapport dans la foulée** *(acté
2026-08-26)* — même échange, sans attendre une demande, le début du lot ou une livraison. Elle
descend en **Questions tranchées** avec sa date et sa source, et la section d'où elle vient est
mise à jour (« Aucune — Qn tranchée le … »). Ce qui vaut pour une question tranchée vaut pour tout
ce que l'échange change : périmètre, dépendance, hors-périmètre. Le motif de l'arbitrage, lui,
remonte au document qui en est propriétaire (§ 7) ; le rapport y renvoie.

> **Pourquoi** : entre l'arbitrage et sa rédaction, la réponse ne vit que dans la conversation —
> qui ne fait pas foi et ne survit pas à la session. Un rapport qui pose encore une question déjà
> tranchée fera rouvrir le débat.

### Répercussion

Dès qu'un travail décide, contraint ou invalide quelque chose dans un lot **pas encore livré** :

- si son rapport **existe**, le mettre à jour dans la foulée (question tranchée, périmètre modifié,
  dépendance nouvelle) ;
- s'il **n'existe pas**, le noter dans le rapport de pilotage pour que ce soit repris à sa rédaction.

**Jamais dans un rapport livré** — voir le gel, § 6.

## 4. La structure `developpement/`

**Toujours à la racine du projet**, à côté des documents de référence et du code.

| Emplacement | Contenu |
|---|---|
| `rapport-pilotage.md` | **le reste à faire, et rien d'autre** — les lots ouverts et l'ordre de les prendre |
| `arbitrages-transversaux.md` | les décisions qui dépassent un lot unique, datées et **figées** |
| `lots/` | **réserve** — rapports rédigés, pas encore rattachés à une phase |
| `phase-N/` | les lots de la phase en cours, et sa revue d'ouverture |
| `phase-N/livraisons/` | ceux de ces lots qui sont **livrés** — pour lire d'un coup d'œil ce qui reste |
| `phase-N/recettes/` | les recettes de la phase (§ 10) |
| `livraisons/` | les **phases closes**, entières et figées |
| `maquettes/` | les références visuelles des écrans |

Trois principes portent cette organisation :

1. **Ce qui est vivant et ce qui est figé ne se mélangent pas** — jamais dans le même dossier.
2. **Le pilotage se vide, l'historique s'accumule.** Ce qui est livré sort du pilotage ; ce qui est
   tranché en sort aussi. Chacun a son dossier ou son fichier.
3. **Un fait de suivi n'a qu'un seul exemplaire** *(acté 2026-08-21)*. Chaque donnée vivante a un
   fichier propriétaire — l'ordre du reste à faire au rapport de pilotage, la liste des lots livrés
   au rapport de livraisons de la phase, l'objet et le critère d'appartenance d'une phase à son
   `README.md`. Tout autre fichier **renvoie**, il ne recopie pas.

   > **Pourquoi** : une copie à maintenir à la main finit toujours par diverger, et chaque décision
   > coûte alors autant d'éditions que d'exemplaires. La divergence a été constatée, pas supposée :
   > la liste des livrés, tenue en trois endroits, était fausse dans l'un des trois.

Le rapport de pilotage est un **outil de travail**, pas une source de vérité : quand il contredit les
documents de référence, ce sont eux qui ont raison.

## 5. Le cycle de vie d'un lot

1. **Rédigé** sur demande → naît dans `lots/`.
2. **Rattaché à une phase** → `git mv` vers `phase-N/`. *(Un lot rédigé directement pour la phase en
   cours y naît sans passer par la réserve.)*
3. **Livré** → `git mv` vers `phase-N/livraisons/` ; sa ligne quitte le tableau du pilotage ; une
   synthèse courte rejoint le rapport de livraisons de la phase — ce qui a été livré, et les écarts
   assumés.
4. **Phase close** → le dossier entier part dans `livraisons/`, **figé**.

Le rapport n'est pas réécrit à la livraison : il porte déjà le détail, la synthèse sert à lire
l'historique sans ouvrir chaque fichier.

**Les lots se citent entre eux par identifiant** (« dépend de Lnn »), **jamais par chemin de
fichier** : une migration ne casse alors aucun renvoi.

**Les numéros ne sont jamais réattribués**, même quand un lot est supprimé — le numéro reste vacant.

## 6. Ce qui fait foi, et dans quel ordre

Les **documents de référence** du projet font foi. Ils sont versionnés et éditables : une décision
prise en séance s'y consigne.

### La cible et le chemin

Deux ensembles, deux rôles, qui ne se recouvrent pas :

- **Les documents de référence portent la cible** — l'intention à jour, secteur par secteur. Ils
  disent ce que le projet **doit être**, pas où il en est ni par quels gestes on y va.
- **`developpement/` porte le chemin** — comment on y arrive. Il ne couvre pas forcément toute la
  cible à un instant donné, et c'est normal.

Deux conséquences.

**Le reste à faire ne se déclare pas : il se mesure.** C'est l'écart entre l'état de
`developpement/` et celui des documents de référence. Le rapport de pilotage porte les lots ouverts
et l'ordre de les prendre — il ne prétend pas couvrir toute la distance à la cible.

**Les documents de référence ne citent ni lot, ni phase, ni aucune donnée de suivi.** Un renvoi de
ce genre se périme tout seul, et il brouille la mesure : on ne sait plus si on lit la cible ou
l'étape. Ils citent en revanche le **code** librement — voir « Le sens de la référence » ci-dessous.

> **Pourquoi** : c'est aussi ce qui justifie le verrou. Les documents de référence ne se modifient
> que sur demande explicite — non parce qu'ils seraient sacrés, mais parce qu'une retouche
> d'inattention les dénature, et que tout le travail s'appuie sur eux.

Quand deux sources se contredisent, l'ordre est :

1. **La règle actée** — c'est **le défaut**, toujours.
2. **La maquette** — elle fait foi pour l'écran à produire, avec deux garde-fous :
   - **opposition à une règle actée** → la règle actée gagne. La confirmation se demande pour
     *suivre la maquette*, **jamais l'inverse**. Un conflit trop grand devient une **question
     déterminante** ;
   - **opposition floue** (règle absente, spéculation de la maquette, ambiguïté) → demander
     confirmation avant d'agir.
   Les **écarts techniques** d'une maquette — textes en dur, formats non localisés, couleurs en dur,
   logique côté client — se corrigent **au portage**, jamais recopiés.
3. **Le code livré** — il fait foi pour ce qui existe déjà. **Il n'est pas figé** *(acté
   2026-08-21, levée du gel posé le 2026-08-19)* : tout lot le modifie dans son périmètre, sans
   cérémonie de levée — le projet est jeune, le livré se retravaille. La retouche **hors
   périmètre** reste interdite : une correction « évidente » au détour d'une autre tâche se
   signale, elle ne se fait pas en silence.

### Le gel

**Un rapport livré, une phase close et une entrée d'arbitrage datée ne se retouchent jamais** — même
une ligne devenue fausse. Un compte rendu se lit tel qu'il a été écrit.

Conséquence assumée : l'historique cite des chemins depuis déplacés, des noms depuis abandonnés, des
étiquettes de phase périmées. C'est le comportement voulu, pas une dette.

Quand une décision ultérieure amende du travail livré, la mise à jour va **dans le code, dans les
documents de référence et dans le rapport de pilotage** — jamais dans l'historique du lot qui l'avait
livré.

### Le sens de la référence

**Le code ne cite pas les documents ; les documents citent le code.** Les documents de référence sont
là pour cadrer le travail : c'est à eux de pointer vers le code, jamais l'inverse. Un renvoi en
commentaire devient faux au premier déplacement, et personne ne le voit.

## 7. Les décisions remontent au dépôt

Une décision ne reste pas dans le fil de conversation. Elle **remonte vers le dépôt** — le document
de référence concerné, le rapport concerné, les notes de l'outil concerné — **dans le même commit que
le travail qu'elle justifie**.

Et **quand la décision est vérifiable, on ajoute le contrôle plutôt que de compter sur la
vigilance** : un contrôle mécanique, branché sur la commande de vérification, éprouvé par contrôles
négatifs. Une règle qui ne tient que par la relecture finit par céder.

Vérifier aussi qu'une note ancienne n'a pas péri : un état du dépôt décrit il y a deux jours peut
être faux aujourd'hui.

> **Pourquoi** : des décisions écrites, mais jamais descendues jusqu'aux fichiers, ont été publiées à
> l'envers pendant des semaines. La décision existait ; rien ne la faisait descendre.

## 8. `[à compléter]` : jamais de valeur plausible

Donnée manquante — règle non actée, valeur inconnue, point de méthode non tranché — laisser un
**`[à compléter]` visible**. Jamais une valeur plausible inventée.

Une valeur inventée est indiscernable d'une valeur actée dès le lendemain.

## 9. Un mot, un concept

Avant d'introduire un terme dans un rapport ou dans le code, vérifier qu'il **ne recouvre qu'un seul
concept**. Si un mot en couvre deux, les séparer explicitement — un encadré « Terminologie » dans le
rapport concerné.

> **Pourquoi** : un terme ambigu dans un rapport devient une ambiguïté d'architecture au moment de
> coder. Et les arbitrages référencent les concepts par leur nom.

## 10. La recette

Avant la livraison d'un lot qui touche l'interface, l'auteur du projet essaie le résultat et écrit
ses constats **dans son langage, une ligne par point**. Le fichier vit dans `phase-N/recettes/`.

**Étape à la discrétion de l'auteur du projet, pour tout lot** *(acté 2026-09-19)*. Claude rend
la main quand le travail est fait et **ne livre jamais de lui-même** : la fenêtre de recette est
toujours ouverte. L'auteur peut la sauter et demander directement de livrer.

**Demander la livraison clôt la recette** *(acté 2026-08-25)*. Quand l'auteur du projet demande de
livrer, c'est que la recette est faite **et** qu'elle est bonne : il n'y a ni validation à
réclamer, ni fenêtre d'essai à laisser ouverte après coup. Et **le silence vaut validation** — une
recette se conclut par ce qui est relevé ; rien de relevé, rien à attendre.

> **Pourquoi** : réclamer un « bon pour livraison » après une demande de livraison fait repasser
> l'auteur du projet par une confirmation qu'il vient de donner.

**Pendant la recette, la vérification s'allège** *(acté 2026-08-22)*. Quand les petites retouches
s'enchaînent, les suites lentes (bout en bout, smoke) ne se relancent **pas à chaque demande** —
les contrôles rapides (typage, lint, test unitaire visé) suffisent au fil de l'eau. La
**vérification complète** se joue une fois, en tête de livraison — voir § 2.

> **Pourquoi** : relancer les suites lentes à chaque retouche fait payer plusieurs minutes
> d'attente à chaque échange, pour un risque que la vérification finale couvre de toute façon.

## 11. Écrire court

Tout ce qui est écrit pour être lu par l'auteur du projet — questions, constats, propositions,
rapports, fichiers de suivi — se lit **vite** *(acté 2026-08-21)* : phrases simples, mots comptés,
un point par paragraphe. Ce qui ne change pas la décision du lecteur n'y figure pas.

> **Pourquoi** : l'auteur lit pour trancher. Un rapport de cinquante paragraphes, c'est un
> arbitrage qui ne sera pas rendu.

## 12. Le schéma en production : détruire en trois temps, jamais d'un coup

*(À la demande de l'auteur du projet, 2026-08-29.)* Dès qu'une première version sert en
production, **aucune évolution de schéma ne détruit ce que le code en service utilise encore**.
Toute suppression se joue en trois mouvements :

1. **Ajouter** — la structure nouvelle arrive en base, et le code qui l'emploie avec elle.
2. **Déprécier** — la structure ancienne ne sert plus : le code cesse de la lire et de l'écrire ;
   elle reste en base.
3. **Supprimer** — la structure dépréciée quitte la base, dans une livraison dédiée.

Ces mouvements sont **espacés de plusieurs jours au minimum, plutôt des mois** — hors cas
particulier, qui se justifie explicitement.

> **Pourquoi** : tant que la structure ancienne existe, la version précédente du code fonctionne
> encore — revenir en arrière reste un geste sans restauration, donc sans perte. Et l'espacement
> laisse le temps de constater qu'on ne reviendra pas, avant de rendre le retour impossible.

---

# Partie II — Application à ce dépôt

## Ce qui fait foi ici

- **`docs/`** — versionné et éditable, il est la source de vérité du projet. Il accueille les
  **éléments de définition globaux** de l'application, quand il y en a *(acté 2026-09-19)* ; il
  n'en contient aucun pour l'instant, et rien n'oblige à en écrire. Tant qu'il n'y en a pas, la
  cible se lit dans `CLAUDE.md` (ce qu'est le projet) et dans les rapports de lot.
- **Le code livré** fait foi pour ce qui existe — voir partie I, § 6. Le logiciel a servi sur
  l'édition 2025 avec sa base Isar *(Bastien, 2026-09-19)* : la partie I, § 12 (schéma en trois
  temps) **s'applique**.

## Ce qui est gelé, nommément

- `developpement/livraisons/phase-1/` — phase 1, close le 2026-09-19.

Aucun arbitrage transversal daté.

## Les maquettes

Aucune. `developpement/maquettes/` n'existe pas tant qu'il n'y a rien à y mettre.

## L'état du découpage

Ce document porte les **règles** du suivi, jamais son **état**. Phases ouvertes ou closes, compte
des lots, ordre du reste à faire : tout cela se lit dans `developpement/rapport-pilotage.md` — le
fichier propriétaire, un seul exemplaire (partie I, § 4, principe 3).

## Les commandes qui closent un lot

```bash
dart run build_runner build --delete-conflicting-outputs   # les fichiers générés sont versionnés
flutter analyze                                             # zéro erreur
flutter test
flutter build windows                                       # la seule cible livrée
```

Un critère de fin se **constate**, il ne se déclare pas : le rapport porte ce qui a été observé.

## Contrainte de poste

Le dépôt se travaille **depuis un disque local, sous un chemin court** — la raison est dans
`CLAUDE.md`. Un clone sur un partage réseau ne construit pas.

---

# Annexe A — Gabarits de `developpement/`

À poser tels quels dans un dépôt neuf, en remplaçant `N` par le numéro de la phase.

### `developpement/lots/README.md`

```markdown
# Lots — réserve

Rapports de lots **rédigés, mais pas encore rattachés à une phase**. Ils décrivent du travail à
venir : ni engagé, ni planifié.

Le jour où un lot est rattaché à une phase, son rapport rejoint le dossier de cette phase par
`git mv`, pour que l'historique suive.

Ces rapports peuvent avoir été écrits sous une organisation antérieure et porter du vocabulaire
périmé. Ils sont revalidés au moment d'attaquer le lot, pas avant.

Le reste à faire se lit dans `developpement/rapport-pilotage.md`.
```

### `developpement/phase-N/README.md`

```markdown
# Phase N — dossier de la phase en cours

Ouverte le <date>.

**Objet de la phase** : <ce qui la définit, et le critère d'appartenance d'un lot>.

| Contenu | Quoi |
|---|---|
| `revue-ouverture-phase-N.md` | la revue faite à l'ouverture : constats et questions ouvertes |
| `rapport-livraisons.md` | les synthèses de livraison de la phase |
| ce dossier | les rapports des lots **rattachés et encore ouverts** |
| `livraisons/` | ceux qui sont **livrés** |
| `recettes/` | les recettes |

Un lot rédigé mais pas encore rattaché attend dans `developpement/lots/`. Le reste à faire, tous lots
confondus, se lit dans `developpement/rapport-pilotage.md`.

Ce dossier reste **vivant** tant que la phase est ouverte. À sa clôture, il partira entier dans
`developpement/livraisons/`, figé.
```

### `developpement/livraisons/README.md`

```markdown
# Livrés — les phases closes

Chaque phase close est déposée ici **entière et figée** : plus aucune modification après le
regroupement. C'est de l'historique, pas un outil de travail.

| Phase | Contenu |
|---|---|
| `phase-N/` | <une ligne> |

Conséquence assumée du gel : une phase archivée cite l'organisation et le vocabulaire de son époque —
chemins depuis déplacés, noms depuis renommés. Ces renvois ne sont pas rafraîchis.

La phase en cours vit hors de ce dossier.
```

### `developpement/rapport-pilotage.md` (ossature)

```markdown
# Rapport de pilotage

Dernière mise à jour : <date>.

Point d'entrée du suivi. Il porte **le reste à faire, et rien d'autre**. Ce qui est livré en sort,
ce qui est tranché en sort.

Ce fichier n'est **pas** une source de vérité. La méthode de travail se lit dans
`docs/methode-de-travail.md` ; les règles du projet dans ses documents de référence.

## Prochain geste

## Lots ouverts

Statuts : `à faire` · `en cours` · `bloqué` (question déterminante sans réponse).
Les numéros ne sont **jamais réattribués**.

| # | Lot | Statut | Rapport |
|---|---|---|---|

## Questions transversales en attente
```

# Annexe B — Squelette d'un rapport de lot

```markdown
# Lnn — <titre>

Statut : **à faire** (ouvert le <date>) · <dépendances, ou « Ne dépend d'aucun lot »>

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

## Périmètre

| Cible | Détail |
|---|---|

### Hors périmètre

## Critère de fin

<cible vérifiable — quoi observer, pas « ça marche »>

## Questions déterminantes

- **Qn — <question>** <options réelles, et le défaut proposé>

## Questions non déterminantes

## Choix d'implémentation

- **Cn — <décision affirmée>** <motif en une phrase>

## Questions tranchées

- **Qn — <question>** → **<réponse>** *(source, date)*

## Suggestions
```
