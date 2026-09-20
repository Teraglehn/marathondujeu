# L05 — Génération des cartes joueur paramétrable depuis l'interface

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot.
L09 (sauvegarde) reprendra les réglages ajoutés à `Event`.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

La page *Générateur de carte* imprime aujourd'hui une mise en page **codée en dur** (cartes 201 à
304, 4 colonnes × 2, A4 paysage, QR de 116 pt en (82, 170), numéro en (10, 10)). Elle doit devenir
autonome : tout se règle à l'écran, l'aperçu suit, et les réglages sont **gardés avec
l'événement** (Bastien, 2026-09-19).

## Périmètre

| Cible | Détail |
|---|---|
| Réglages à l'écran | image de fond ; cartes **par ligne** et **lignes par page** ; **orientation** portrait / paysage ; **largeur** de la carte en mm, la hauteur suivant le **ratio de l'image** (C2) ; position et taille du **QR code** en mm ; position, **taille de police** et **couleur** du numéro ; pour le numéro et pour le QR code, un **fond optionnel** : couleur et marge intérieure en mm (C11 ; Bastien, 2026-09-19) ; **couleur de fond de la page**, **marge de page** et **espaces** entre cartes d'une ligne et entre lignes, en mm (C13 ; Bastien, 2026-09-19) ; numéros **de x à y** |
| `Event` | les champs existants — `playerCardWidth`, `playerCardBackgroundImage`, `qrCodeSize`, `qrCodePosX/Y`, `idPosX/Y` — sont enfin alimentés, **en mm** (C3). Ajoutés : `playerCardsPerRow`, `playerCardRowsPerPage`, `playerCardLandscape`, `idFontSize`, `idColor`, `idBackgroundColor`, `idPadding`, `qrCodeBackgroundColor`, `qrCodePadding`, `pageBackgroundColor`, `pageMargin`, `playerCardGapX`, `playerCardGapY` (C4, C11, C13). L'image de fond est **réduite** avant enregistrement (C12) |
| `card_generator_page.dart` | un panneau de réglages à gauche, l'aperçu `PdfPreview` à droite ; un bouton *Enregistrer* qui écrit les réglages sur l'événement (C5) |
| `PlayerCardService` | un calcul de mise en page **pur et testé** : nombre de pages, dernier numéro imprimé (Q1), hauteur de carte, conversion mm → points (C6) ; le QR code contient `sel-numéro` (C1, C10) |
| Feuilles complètes | le nombre de cartes imprimées est un **multiple de cartes par page** : pas de feuille incomplète (Q1) |
| `event_edit_form.dart` | un interrupteur **« Protéger les cartes contre la copie et la réutilisation »** (C8) : allumé, `Event.qrSalt` reçoit un identifiant aléatoire ; éteint, il est vide. Verrouillé dès que des joueurs existent (Q3). Un bouton **« Récupérer la protection depuis une carte imprimée »** : on scanne une carte, le sel en est déduit (C9 ; Bastien, 2026-09-19). Aujourd'hui le champ existe en base mais aucun écran ne le montre : il est toujours vide |
| `event_service.dart`, `Event` | `generateMissingPlayers` écrit `sel-numéro` ; le format vit dans `Event.qrCodeFor` (C10) |
| `Player` | **`number`** (int) séparé du QR code (Bastien, 2026-09-19) : le numéro est affiché partout où le code du QR l'était — liste des joueurs, fiche, groupes, gagnants. Les joueurs existants reçoivent leur numéro à l'ouverture de la base (C14) |
| Textes | libellés des réglages, fr/en ; le « select image » en dur disparaît |

### Hors périmètre

- Créer les joueurs correspondant aux cartes imprimées : c'est *Générer les joueurs manquants*
  sur la page des joueurs (voir Suggestions).
- Le format de page : A4 seulement (Q2).
- La police du numéro : celle du PDF par défaut.
- La suppression des anciens champs de `Event` devenus inutiles : aucun ne l'est (C3).
- L'export ou la sauvegarde du fichier PDF : `PdfPreview` sait déjà imprimer.

## Critère de fin

1. Sur un événement neuf, avec une image de fond de ratio 2:3, largeur 60 mm, 3 cartes par ligne,
   3 lignes, portrait, numéros 1 à 20 : l'aperçu montre **3 pages de 9 cartes**, numérotées 1 à
   27 (Q1 a), chaque carte de 60 × 90 mm à l'impression 100 %.
2. Changer un réglage met l'aperçu à jour sans autre geste.
3. *Enregistrer*, quitter la page, redémarrer l'application : les réglages et l'image sont
   retrouvés.
4. Une carte imprimée, scannée à la douchette sur la page des joueurs, **ouvre la fiche du
   joueur** de ce numéro — y compris si `qrSalt` n'est pas vide (C1).
5. Sur un événement neuf sans joueur, *Récupérer la protection depuis une carte imprimée* puis
   un scan d'une carte protégée : l'interrupteur s'allume, et les joueurs générés ensuite sont
   reconnus par ces cartes (C9).
6. `flutter analyze` propre, `flutter test` vert (calcul de mise en page et extraction du sel
   testés), `flutter build windows` passe.

**Constaté le 2026-09-19** :
1–3. Recette Bastien : « générateur de cartes bon, L05 me semble complet ». Le critère 1 est
couvert par le test `CardLayout` (3 pages, 27 cartes, 60 × 90 mm en points) ; les mm à
l'impression 100 % n'ont pas été mesurés sur papier.
4–5. Non essayés à la douchette pendant la recette : le code `sel-numéro` et son extraction sont
testés ; la boîte « Scannez une carte » est à constater à la première impression protégée.
6. `flutter analyze` : `No issues found!` ; 32 tests verts (12 nouveaux) ; `flutter build windows`
construit.
Écarts : panneau fixe plutôt qu'éditeur latéral (C5) ; mm décimaux (C3) ; aperçu rapide Flutter
avant l'aperçu PDF (C15) ; `flex_color_picker` rétrogradé (C11) ; `Player.number` (C14) ;
suppression des joueurs depuis le formulaire d'événement (C16).

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2, Q3 tranchées le 2026-09-19.

## Choix d'implémentation

- **C1 — Le QR code porte `sel-numéro`** (C10), le numéro seul est imprimé en clair — le même
  code que `generateMissingPlayers` écrit dans `Player.qrcode`. Aujourd'hui le générateur met le
  numéro nu, et une carte ne serait pas reconnue dès que le sel n'est pas vide. Le sel sert à ce
  qu'une carte d'une autre édition ne soit pas reconnue : il est propre à l'événement.
- **C2 — La hauteur de la carte se déduit de l'image** : largeur saisie × (hauteur / largeur de
  l'image), lue par `instantiateImageCodec` de Flutter — pas de dépendance nouvelle. L'image est
  dessinée en `BoxFit.fill` : elle occupe exactement la carte, sans marge ni rognage.
- **C3 — Les réglages sont en millimètres, décimaux** (`double`, une décimale à l'écran, virgule
  ou point — Bastien, 2026-09-19), y compris les champs existants de `Event` (`playerCardWidth`,
  `qrCodeSize`, `qrCodePosX/Y`, `idPosX/Y`), qui passent d'`int` à `double` : jamais alimentés,
  ils n'ont aucune donnée à migrer. **Vérifié sur une copie de la base réelle** : Isar ouvre,
  rend `NaN` pour un champ dont le type a changé et la valeur nulle pour un champ ajouté ;
  `CardSettings.fromEvent` ramène les deux au défaut. La taille de police reste en points. `playerCardHeight` n'est ni écrit
  ni lu : il reste en base (partie I, § 12, temps 2 — rien à supprimer).
- **C4 — Treize champs ajoutés à `Event`**, avec valeur par défaut — temps 1 de la partie I, § 12 :
  Isar les ajoute sans migration. Défauts : 4 par ligne, 2 lignes, paysage, police 12, numéro
  noir, pas de fond, marges 0, page blanche, marge de page 0, espaces 0. Sur un
  enregistrement antérieur, Isar rend la **valeur nulle** (entier minimal) pour un champ ajouté :
  `CardSettings.fromEvent` remplace toute valeur négative (ou 0 pour une taille) par le défaut —
  testé.
- **C5 — Les réglages s'éditent sur la page du générateur**, dans un **panneau fixe à gauche de
  l'aperçu**, pas dans le formulaire d'événement ni dans l'éditeur latéral : on règle en voyant,
  et le tiroir (50 % de la fenêtre) couvrirait la moitié de l'aperçu (proposé par Bastien,
  laissé à l'UX, 2026-09-19). Un seul bouton *Enregistrer* écrit l'événement ;
  la plage x–y n'est pas enregistrée (elle change à chaque tirage de cartes ; défaut 1 à
  nombre de joueurs de l'événement).
- **C6 — Le calcul de mise en page est une fonction pure** (`CardLayout` ou équivalent dans
  `PlayerCardService`) : entrées = réglages + ratio d'image, sorties = points par carte, cartes
  par page, nombre de pages, dernier numéro. Testée sans PDF. Le rendu PDF reste non testé.
- **C7 — Les positions se comptent depuis le coin haut-gauche de la carte**, comme aujourd'hui ;
  aucune contrainte de dépassement — un QR mal placé se voit dans l'aperçu.
- **C8 — Le sel n'est jamais saisi** : un interrupteur le crée ou l'efface. Allumé → `qrSalt` =
  les 8 premiers caractères hexadécimaux d'un UUID v4 (paquet `uuid`, déjà présent) — assez
  pour qu'une carte d'une autre édition ne soit pas reconnue, court pour garder un QR lisible à
  petite taille. Éteint → `qrSalt` vide. Le texte explique ce que protège l'interrupteur.
- **C9 — Récupérer le sel depuis une carte** : le QR contient `sel-numéro` (C10) et le numéro est
  imprimé en clair ; le sel est le code scanné **privé de son dernier « - » et de ce qui suit**. Un bouton du
  formulaire, visible seulement quand aucun joueur n'existe (Q3), ouvre une boîte « Scannez une
  carte » qui écoute la douchette (`BarcodeKeyboardListener`, sans passer par les joueurs),
  remplit `qrSalt` et allume l'interrupteur. Sert quand les réglages sont perdus alors que les
  cartes sont déjà imprimées.
- **C14 — `Player.number` et sa migration** : temps 1 du § 12, champ ajouté ; `name` continue de
  porter le numéro en texte (règle actée du 2026-09-19), sans changement. À l'ouverture de la
  base, `IsarClient.migratePlayerNumbers` numérote une fois les joueurs qui n'en ont pas : depuis
  `name`, sinon depuis la fin du code (après le dernier « - »). Testé sur base.
- **C15 — Aperçu rapide avant l'aperçu PDF** (recette, 2026-09-19) : la première page est dessinée
  par Flutter à l'échelle (`CardSheetPreview`, mêmes calculs `CardLayout`) et suit chaque frappe ;
  l'aperçu PDF (`PdfPreview`, toutes les pages) se rend sur demande, par un sélecteur en tête de
  l'aperçu. Le rendu du PDF à chaque modification était trop lent.
- **C16 — Supprimer les joueurs depuis le formulaire d'événement** (Bastien, 2026-09-19) : dans
  le bloc protection, quand des joueurs existent, un bouton rouge avec confirmation qui dit ce
  qu'on perd (badgeages, gagnants, reconnaissance des cartes). `EventService.destroyPlayers`
  existant. C'est le geste qui déverrouille la protection (Q3).
- **C10 — Format du code : `sel-numéro`**, le numéro **toujours après le dernier « - »** ; sans
  protection, le numéro seul (Bastien, 2026-09-19). Le sel peut donc contenir n'importe quoi.
  `generateMissingPlayers` (`event_service.dart`, ligne 137) passe de `qrSalt + i` à ce format :
  aucune donnée touchée, le sel a toujours été vide. Un `Event.qrCodeFor(number)` porte le format,
  utilisé par la génération des joueurs et par le générateur de cartes.
- **C11 — Couleur du numéro, fonds du numéro et du QR code** : couleurs en `int` ARGB sur `Event`
  (`idColor`, et `idBackgroundColor` / `qrCodeBackgroundColor` **nullables** : `null` = pas de
  fond) ; marge intérieure en mm (`idPadding`, `qrCodePadding`). Le fond est un rectangle plein
  derrière le contenu, agrandi de la marge de chaque côté ; la position saisie reste celle du
  fond (coin haut-gauche, C7). Sélecteur : `ColorSelector` existant (`flex_color_picker`).
  **`flex_color_picker` rétrogradé de 4.0.0 à 3.8.0** (recette, 2026-09-19) : la 4.x est bâtie sur
  `material_ui`, dont le `MaterialLocalizations` n'est pas celui de `flutter/material` que
  l'application fournit — le sélecteur plantait à l'ouverture. Latent depuis L08 : aucun écran
  ne l'utilisait.
- **C12 — L'image de fond est réduite à l'enregistrement**, jamais agrandie : ramenée à 300 dpi
  de la largeur de carte (60 mm → ~710 px) par `instantiateImageCodec(targetWidth:)` de Flutter,
  sans dépendance. C'est cette version qui va dans `Event.playerCardBackgroundImage` et dans le
  PDF — `pdf` l'incorpore une fois par document quand la même `MemoryImage` sert à toutes les
  cartes. Changer la largeur de carte après coup ne ré-agrandit pas : l'image d'origine n'est
  pas gardée ; il faut la refournir (Bastien, 2026-09-19).
- **C13 — Couleur de fond de la page, marge de page, espaces entre cartes** :
  `pageBackgroundColor` (ARGB, défaut blanc) peint toute la page sous les cartes ; `pageMargin`
  (même valeur sur les quatre côtés), `playerCardGapX` (entre cartes d'une ligne) et
  `playerCardGapY` (entre lignes), en mm. La grille est **centrée** dans la page moins sa marge ; si elle dépasse la page, l'aperçu le montre — pas de contrainte (C7) (Bastien,
  2026-09-19).

## Questions tranchées

- **Q1 — Dernière feuille incomplète : compléter, ou refuser ?** → **(a) compléter** : on imprime
  jusqu'au numéro qui remplit la dernière page, et l'écran affiche « cartes 1 à 27, 3 pages ».
  Écarté : *(b)* refuser tant que y − x + 1 n'est pas un multiple. *(Bastien, 2026-09-19)*
- **Q2 — Format de page : A4 seul, ou au choix ?** → **(a) A4 seul**. Écarté : *(b)* une liste
  A4 / A3 / Letter. *(Bastien, 2026-09-19)*
- **Q3 — Le sel reste-t-il modifiable une fois des joueurs générés ?** → **(a) non, verrouillé** :
  leurs `qrcode` et les cartes imprimées portent l'ancien sel. L'interrupteur se grise avec
  l'explication « des joueurs existent ». Écarté : *(b)* modifiable avec avertissement.
  *(Bastien, 2026-09-19)*

## Suggestions

- Depuis le générateur, proposer de **créer les joueurs manquants jusqu'à y** en un clic : les
  cartes imprimées correspondent alors à des joueurs qui existent, sans passer par l'autre page.
- Un **gabarit de démonstration** (image de fond par défaut) pour que la page ne soit pas vide
  avant le choix d'une image — utile au tutoriel (L12).
- **Pré-remplir la largeur de carte depuis la résolution de l'image** (PNG `pHYs`, JPEG JFIF /
  EXIF) quand elle est présente et différente des 72 / 96 dpi par défaut : confort pour un
  gabarit fait à 300 dpi, mais une dépendance de plus (`image`) — Flutter ne lit pas cette
  métadonnée. Écarté du périmètre pour cette raison (Bastien, 2026-09-19).
