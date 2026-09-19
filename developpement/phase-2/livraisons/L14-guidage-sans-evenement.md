# L14 — Guidage sans événement

Statut : **livré** le 2026-09-20 (ouvert le 2026-09-19) · Ne dépend d'aucun lot.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Tout part d'un événement : sans lui, cinq pages sur six n'ont rien à montrer. Aujourd'hui elles
affichent « Veuillez sélectionner un évènement » et attendent. Le lot **conduit** l'utilisateur
(Bastien, 2026-09-19) :

1. arriver sur une page qui exige un événement sans en avoir choisi **ouvre le sélecteur**
   d'office ;
2. **aucun événement en base** → les entrées du rail qui en exigent un sont **grisées**, et
   toute arrivée sur ces pages **redirige** vers la liste des événements ;
3. liste des événements **vide** → un grand bloc central « Créer un événement ».

## État du code (constats 2026-09-19)

- `EventSelectedGuard` : si `selectedEventProvider` est vide, un texte centré ; sinon la page.
- Le sélecteur (`EventSelector`, un `SearchSelector`) est dans la barre de cinq pages ; il
  s'ouvre au clic (`SearchController.openView`) — rien ne l'ouvre par programme aujourd'hui.
- Le rail (`MainRail`) : six `NavigationRailDestination`, sans état désactivé ; la propriété
  `disabled` existe dans Flutter.
- La route initiale est `/` = liste des événements (`routes.dart`).
- **L'événement sélectionné n'est pas retenu** entre deux lancements : `MainState` vit en
  mémoire (`MainPod`). Chaque ouverture commence sans événement.

## Périmètre

| Cible | Détail |
|---|---|
| `EventSelectedGuard` | sans événement : ouvre le sélecteur de la page **une fois** à l'arrivée (C1) ; le corps montre le message et un bouton **« Choisir un événement »** qui le rouvre |
| `MainRail` | aucun événement en base (pod `events`) → destinations *Joueurs, Groupes, Sessions, Tirages, Générateur* **désactivées**, infobulle « Créez d'abord un événement » (C2) |
| Redirection | arriver sur l'une de ces routes sans événement en base → `go` vers la liste des événements (C3) |
| Liste des événements vide | un bloc central : icône, titre **« Créer un événement »**, une phrase (« Tout commence par un événement : ses dates, ses sessions, ses joueurs. »), un bouton qui ouvre l'éditeur — le « + » reste (C4) |
| Textes | fr/en |
| `docs/gestes.md` | TR-1, TR-2, EV-1 mis à jour dans le même commit |

### Hors périmètre

- Le contenu de l'aide de ces écrans (L12).
- Supprimer un événement (absent aujourd'hui, EV-10) : hors sujet ici.
- Un événement « par défaut » créé tout seul : non — on guide, on ne décide pas à la place.
- Retenir l'événement sélectionné d'un lancement à l'autre : non (Q1 b) — chaque lancement
  commence sans événement, le sélecteur d'office fait le travail.

## Critère de fin

1. Base vide, lancement : la liste des événements s'affiche avec le grand bloc « Créer un
   événement » ; les cinq entrées du rail sont grises, leur infobulle le dit ; cliquer dessus
   ne quitte pas la page.
2. Créer un événement : le bloc disparaît, le rail s'active.
3. Sans événement sélectionné, aller sur *Joueurs* : le sélecteur s'ouvre de lui-même ; le
   fermer sans choisir laisse le message et le bouton « Choisir un événement » ; choisir affiche
   la page.
4. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 tranchée le 2026-09-19.

## Choix d'implémentation

- **C1 — Le sélecteur s'ouvre une fois par arrivée sur la page**, pas à chaque reconstruction :
  la garde porte **son propre** `EventSelector` (le bouton « Choisir un événement »), avec une
  option `autoOpen` de `SearchSelector` qui ouvre la vue en `postFrameCallback` à la création du
  widget. Le corps « sans événement » n'est créé qu'à l'arrivée : fermer sans choisir n'entre pas
  en boucle. Le sélecteur de la barre suit la valeur choisie (`SearchSelector` relit
  `initialValue` quand il change — aujourd'hui `FormField` l'ignore). Les pages ne changent pas.
- **C2 — Le rail lit le pod `events`** (`eventsProvider`, existant) : liste vide → `disabled`
  sur les cinq destinations. Le rail passe de `StatelessWidget` à `ConsumerWidget`.
- **C3 — La redirection est dans `EventSelectedGuard`**, qui protège déjà les pages *(Bastien,
  2026-09-19)* — pas de `redirect` go_router : un seul point, qui lit le pod `events`. Base vide →
  `goNamed(eventList)` en `postFrameCallback`. Elle ne s'applique qu'à « aucun événement en base »,
  jamais à « aucun sélectionné » (C1 s'en charge). Tant que les pods chargent, la garde n'affiche
  rien et ne décide rien.
- **C4 — Le bloc « Créer un événement » remplace la liste vide**, il n'est pas en plus : une
  liste vide n'a rien à montrer. Il ouvre `editor.editEvent(null)`, comme le « + ».
- **C5 — retiré** (Q1 b) : pas de préférence locale.
- **C6 — Pas de test de widget** : la redirection et la lecture du pod se constatent à la
  recette.

## Questions tranchées

- Les trois comportements (sélecteur d'office, rail grisé + redirection, bloc central) —
  *(Bastien, 2026-09-19)*.
- **Q1 — Retenir l'événement entre deux lancements ?** *(b)* **non** *(Bastien, 2026-09-19)* :
  C5 retiré, critère 4 retiré.
- **C3** — la redirection vit dans la garde, pas dans le routeur *(Bastien, 2026-09-19)*.

## Suggestions

- **Le sélecteur d'événement dans le rail** plutôt que dans cinq barres : un seul endroit, toujours
  visible, et le guidage n'a plus qu'une porte. Changement de mise en page, hors de ce lot.
