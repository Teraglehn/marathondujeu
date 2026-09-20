# L12b — Page d'aide globale : le parcours d'une édition, dans le rail

Statut : **à faire** (ouvert le 2026-09-20) · dépend de **L12** (les aides de page existent avant
le guide qui y renvoie) · **en dernier**, après L12.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Une **page d'aide**, entrée du rail de gauche, qui explique **le parcours d'une édition** de bout
en bout : créer l'événement, générer sessions et joueurs, imprimer les cartes, badger, tirer,
lire les gagnants. Elle montre **visuellement** ce que l'écran affiche (billes, couleurs des
sessions, barre de scan…) plutôt que de le décrire en mots seuls. Issue de L12 Q2, tranchée
*(b)* : un guide global **en plus** des aides de page *(Bastien, 2026-09-20)*.

### Terminologie

- **Guide** : cette page — le parcours entier, une lecture, pour quelqu'un qui découvre.
- **Aide de page** : le « i » de chaque page (L12) — une page, ses gestes.
- **Illustration** : ce que le guide montre d'un écran, quel qu'en soit le procédé (Q1).

## État du code (constats 2026-09-20)

- Le rail (`MainRail`) a **six** entrées, en dur dans `MainRail.routes` ; sans événement en base,
  les cinq hors *Événements* sont grisées. Le geste TR-1 de `docs/gestes.md` dit « six entrées ».
- **Peu de composants réutilisables** : `PlayerBubble` (la bille d'un joueur), `CardSheetPreview`
  (l'aperçu de la planche de cartes), `ScanStatus` (la barre de scan), `Toast`. Les cartes de
  session, les lignes de joueurs, les tirages sont construits **en privé dans chaque page** —
  pas de widget à poser tel quel dans le guide.
- `ScanStatus` et les pages lisent des pods : les rendre hors contexte demande des surcharges de
  providers.
- Le parcours e2e de L18 (`test/e2e/parcours_test.dart`) joue une édition entière sur la vraie
  application : un point d'accroche possible pour produire des captures à jour (Q1 *c*).

## Périmètre

| Cible | Détail |
|---|---|
| `src/ui/pages/help/help_page.dart` | la page du guide, route `help`, **septième entrée** du rail, en dernier, icône `help_outline` ; **jamais grisée** (C1) |
| Contenu | en tête, **où trouver l'aide** : les trois niveaux de L12, montrés (Q2) ; puis le parcours d'une édition, **une étape par section**, dans l'ordre chronologique ; chaque étape nomme la page où elle se joue et renvoie à son « i » (C2) |
| Illustrations | une par étape au moins, selon Q1 |
| Textes | `help_guide_*`, fr/en (C3) |
| `docs/gestes.md` | TR-1 passe à sept entrées ; un geste **TR-6** « Ouvrir le guide » avec son étape du parcours e2e |

### Hors périmètre

- Les aides de page et le pas à pas en overlay : L12.
- Une aide « première fois » ouverte d'elle-même (L12, suggestions).
- Extraire des composants **au-delà** de ce que le guide affiche : on extrait ce que le guide
  montre, rien de plus.

## Critère de fin

1. Le rail a sept entrées ; la dernière ouvre le guide, événement ou pas.
2. Le guide se lit en une fois, de haut en bas ; chaque étape a son illustration et son renvoi
   vers la page concernée.
3. Une personne qui n'a jamais vu l'application peut, avec le seul guide, dire dans quel ordre
   elle passe par les pages, à quoi ressemble un joueur badgé, et où cliquer pour avoir de
   l'aide sur une page.
4. Les illustrations correspondent à l'écran réel du jour de la livraison (contrôle à la recette).
5. `flutter analyze` propre, `flutter test` vert (le parcours e2e ouvre le guide),
   `flutter build windows` passe.

## Questions déterminantes

Aucune — Q1 tranchée le 2026-09-20.

## Questions non déterminantes

Aucune — Q2 tranchée le 2026-09-20.

## Choix d'implémentation

- **C1 — Toujours accessible** : le guide ne dépend d'aucun événement ; c'est la page qui dit
  comment en créer un. Il échappe donc au grisage du rail et à `EventSelectedGuard`.
- **C2 — Une étape, une section** : titre, deux ou trois phrases, l'illustration, un bouton
  vers la page. Les intertitres reprennent les noms des entrées du rail.
- **C3 — Textes en ARB**, une clé par phrase, comme L12 C4.
- **C4 — Sans image en dur dans les textes** : une illustration est un widget ou un asset, jamais
  un chemin dans une chaîne ARB.

## Questions tranchées

- **Q1 — Comment illustrer ?** → **les vrais composants**, rendus dans le guide avec des données
  d'exemple. Les cartes de session et la ligne de joueur, aujourd'hui méthodes privées des
  pages, sont extraites en widgets purs (sans pod) que les pages appellent à leur tour — rien
  ne change à l'écran. Écarté : des captures en assets (périmées à chaque retouche, comme en
  L12 Q1) ; des captures produites par le parcours e2e (chaîne à monter, rendu de test ≠
  rendu Windows). Les captures restent le repli pour ce qui ne s'extrait pas (dialogue,
  tiroir). *(Bastien, 2026-09-20)*
- **Q2 — Niveau de détail ?** → **le parcours général, plus l'explication des zones d'aide** :
  une section en tête montre les trois niveaux d'aide de L12 (les petits « i » à infobulle, les
  blocs d'information dans l'écran, le grand « i » de la barre qui lance le pas à pas) et dit
  où les trouver. Le détail des gestes de chaque page reste dans son « i » — pas de doublon.
  *(Bastien, 2026-09-20)*

## Suggestions

- Un bouton **« Guide »** dans `_NoEventBody` (« Veuillez sélectionner un événement ») : le
  moment où quelqu'un est perdu.
- Si Q1 *(a)* : les widgets extraits servent aussi aux **aides de page** de L12 (« comment lire
  l'écran » montre la bille plutôt que de la décrire).
