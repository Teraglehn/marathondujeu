# L12 — Aide et tutoriels : un bouton « i » sur chaque page

Statut : **livré le 2026-09-20** (ouvert le 2026-09-19, Q1 tranchée le 2026-09-19, Q2 le 2026-09-20, attaqué le
2026-09-20) · **En dernier** : après tout le retravail de l'application (Bastien, 2026-09-19) — le
tutoriel décrit les écrans finaux.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

L'application est utilisée par des **personnes non techniques** : chaque écran doit s'expliquer
*(acté 2026-09-19, `CLAUDE.md`)*. Ce lot pose **trois niveaux d'aide** (Bastien, 2026-09-19) :

1. des **petits « i » dispersés**, avec une infobulle d'une phrase, là où un champ ou un bouton
   demande un mot ;
2. des **blocs d'information** dans l'écran, là où il y a la place (comme la légende de la fiche
   joueur) ;
3. le **grand « i »** de chaque page, en haut à droite de la barre, toujours au même endroit, qui
   lance le **tutoriel complet** de la page : un pas à pas en overlay sur le vrai écran (Q1),
   **« malin »** — il s'adapte aux données présentes (pas de tirage → le pas dit où ils
   apparaîtront ; un tirage effectué → il montre la lecture seule et la copie).

### Terminologie

- **Aide de page** : le texte qu'ouvre le « i » — propre à la page, en une lecture.
- **Légende** : un texte court posé dans l'écran lui-même (comme dans la fiche joueur, L11).
  Ce lot n'ajoute que celles qui manquent à la lecture d'un écran ; l'aide de page fait le reste.

## État du code (constats 2026-09-19)

- **`docs/gestes.md`** relève les gestes de chaque page, avec leurs variantes selon l'état
  (Bastien, 2026-09-19) : c'est la **source** du contenu des aides — *Ce que vous pouvez faire*
  reprend les gestes de la page, un par un — et de l'appairage avec les tests (C6).
- Huit pages, toutes avec une `AppBar` : événements, joueurs, groupes, un groupe, sessions, une
  session, tirages, générateur de cartes. Cinq portent le sélecteur d'événement à droite
  (`actions`), une session a un bouton retour à gauche.
- Aucune aide nulle part. Légendes existantes : fiche joueur (L11), générateur (L05), éditeur de
  tirage (L06).
- Les textes sont en ARB fr/en, générés — l'aide y va aussi.

## Périmètre

| Cible | Détail |
|---|---|
| `src/ui/widgets/help/` | `HelpButton` (icône `info_outline`) qui lance le pas à pas de la page (Q1), posé **en dernier** dans les `actions` de chaque `AppBar` (C1) ; `HelpTour`, le pas à pas lui-même (C7) ; `HelpHint`, le petit « i » à infobulle (C8) |
| Contenu | une aide par page, huit, structurée pareil : **à quoi sert la page**, **ce qu'on y fait** (les gestes, dans l'ordre), **comment lire** (couleurs, billes, chiffres) (C2). Rédigée par Claude, corrigée à la recette (C3) |
| Textes | `help_<page>_*`, fr/en ; les gestes cités reprennent mot pour mot les libellés des boutons |
| Légendes manquantes | liste des joueurs (jetons, bille grise) — *les sessions (L13) et la page d'une session en avaient déjà une, constaté le 2026-09-20* |
| Petits « i » | *Nombre de joueurs* ; *Badgeage manuel*, *Numéro*, *Mode suppression* (page d'une session) ; *Ajouter par numéro*, *Mode suppression* (page d'un groupe). Liste à ajuster à la recette |
| `docs/gestes.md` | geste **TR-6** « Ouvrir l'aide de la page », avec son étape du parcours e2e (C9) |

### Hors périmètre

- L'aide des éditeurs latéraux : leurs champs portent déjà des explications (L05, L06, L11) ; le
  « i » de la page couvre le reste.
- Revoir le contenu des pages elles-mêmes : L13 pour les sessions ; le reste, lot par lot.
- Le guide global du parcours d'une édition : **L12b** (Q2).

## Critère de fin

1. Sur chacune des huit pages, un « i » au même endroit ; il ouvre l'aide de **cette** page.
2. Chaque aide tient en une lecture (au plus une douzaine de lignes) et ses trois parties sont
   là. Une personne qui n'a jamais vu l'application peut, avec la seule aide de la page
   *Sessions*, ouvrir une session et badger un joueur.
3. L'aide se ferme par la croix, par *Passer* / *Terminer* et par Échap ; elle n'empêche pas la
   douchette après fermeture.
4. Les légendes manquantes sont posées ; celles des lots précédents sont inchangées.
5. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-20** : 1. huit `HelpButton`, dernier des `actions`, chacun avec ses pas ;
2. de 5 à 9 pas par page, une ou deux phrases chacun ; le critère « badger avec la seule aide »
se juge à la recette (Bastien, 2026-09-20 : un pas des groupes reformulé, le reste accepté) ;
3. croix, *Passer*, *Terminer*, Échap joués à l'étape 10 du parcours, scan muet pendant, actif
après ; 4. légende de la liste des joueurs posée, les autres inchangées ; 5. analyse propre,
85 tests verts, build passé.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q2 tranchée le 2026-09-20.

## Choix d'implémentation

- **C1 — Un seul widget, une seule place** : `HelpButton(help: PageHelp)` en dernier dans les
  `actions`, sur les huit pages. Le sélecteur d'événement reste devant lui. Sur la page d'une
  session, le bouton retour reste à gauche.
- **C2 — Trois parties fixes** dans chaque aide, avec les mêmes intertitres : *À quoi sert cette
  page*, *Ce que vous pouvez faire*, *Comment lire l'écran*. Un modèle `PageHelp(title, purpose,
  actions: [...], reading: [...])` ; la boîte les rend toujours pareil.
  **Amendé le 2026-09-20** (Q1 a changé la forme) : les trois parties deviennent **l'ordre des
  pas** — premier pas sans cible = à quoi sert la page ; pas suivants = les zones, dans l'ordre
  des gestes de `docs/gestes.md` ; dernier pas = comment lire (légende, couleurs). Le modèle
  est `HelpStep(text, target: GlobalKey?)`.
- **C3 — Contenu rédigé par Claude, corrigé à la recette** : Bastien connaît l'usage réel, la
  recette est le bon moment. Les textes évitent tout mot technique (pas de « QR », mais « le
  code de la carte » ; pas de « session » sans dire que c'est un créneau de badgeage).
- **C4 — Textes en ARB**, une clé par phrase (`help_session_purpose`, `help_session_action_1`,
  …) : le fr et l'en restent alignés, et rien n'est en dur.
- **C5 — Pas de test de widget** : le mécanisme est un bouton et une boîte ; le contenu se lit à
  la recette (critère 2). **Amendé le 2026-09-20** : L18 appaire chaque geste à un test ; ouvrir
  l'aide est un geste (TR-6), il a son étape du parcours (C9). C5 ne vaut plus que pour le
  contenu des pas.
- **C6 — Chaque geste de l'aide renvoie à un test** (Bastien, 2026-09-19) : l'aide d'une page
  ne cite que des gestes de `docs/gestes.md`, et chaque geste cité a un test — de service quand
  il existe, de widget sinon (ce lot les écrit pour les gestes qu'il décrit, ou les liste comme
  reste à faire dans le rapport de pilotage). C5 ne vaut que pour le bouton et la boîte.
  **Amendé le 2026-09-20** : les tests sont l'objet de **L18** (tests unitaires pour la logique,
  un parcours e2e pour les gestes) — L12 **cite** les gestes, il n'écrit plus de test. Si L12
  passe avant L18, l'aide cite le geste et sa ligne de `docs/gestes.md`, sans test.
- **C7 — Le pas à pas est une route transparente sur le navigateur racine** (`HelpTour`) :
  la page reste rendue dessous, le voile couvre toute la fenêtre, rail compris. La cible est
  repérée par une `GlobalKey` tenue par la page, amenée à l'écran (`Scrollable.ensureVisible`)
  puis mesurée ; un pas dont la clé n'est pas montée est sauté. Les pas se construisent **à
  l'ouverture** avec les données de la page — c'est là que vit le « malin ». Couleurs du thème
  (`scrim`, `primary`, `surface`), aucune en dur ; pas de dépendance tierce.
- **C8 — Douchette muette pendant le pas à pas** : `PlayerSessionScanner` ignore un scan dès
  qu'une route est poussée sur le navigateur racine (`rootNavigatorKey.currentState.canPop()`).
  Ce garde-fou vaut aussi pour les boîtes de dialogue, qui sont sur ce même navigateur : c'est
  ce que TR-4 disait déjà (« boîte de dialogue ouverte → rien »), mais le test `isCurrent`
  en place ne le voyait pas — les dialogues ne sont pas dans le navigateur des pages.
- **C9 — Une étape du parcours** (étape 10) : ouvrir l'aide de la page d'une session, parcourir
  ses neuf pas, constater qu'un scan pendant le pas à pas ne change rien, *Terminer*, scanner
  (le scan agit), puis Échap et *Passer*.

## Questions tranchées

- **Q1 — Forme de l'aide ?** → **un pas à pas en overlay** sur le vrai écran : voile sombre, trou
  autour de l'élément visé (repéré par une clé de widget), bulle avec une ou deux phrases,
  *Suivant* / *Passer* ; sans dépendance tierce. Il montre, il ne fait pas faire ; une cible
  absente est sautée ou remplacée par un texte adapté. Écarté : une série de modales avec
  captures d'écran — à refaire à chaque retouche, et l'utilisateur regarde une image au lieu de
  son écran. *(Bastien, 2026-09-19)*
- **Q2 — Un point d'entrée commun ?** → **oui** : une page d'aide globale dans le rail, en plus
  des huit aides de page. Elle est l'objet de **L12b**, qui vient après ce lot. Conséquence
  ici : l'aide de la page des événements **ne** raconte **pas** le parcours d'une édition —
  c'est le guide qui le fait. *(Bastien, 2026-09-20)*

## Suggestions

- **Une aide « première fois »** ouverte d'elle-même au premier lancement (préférence locale) :
  utile, mais il faut d'abord que les aides existent.
- **Raccourci F1** pour ouvrir l'aide de la page courante.
