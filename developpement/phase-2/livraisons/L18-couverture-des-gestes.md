# L18 — Couverture des gestes par les tests

Statut : **livré** le 2026-09-20 (ouvert le 2026-09-20) · Dépend de **L15** et **L19** (livrés d'abord — Bastien,
2026-09-20). Issu de `docs/gestes.md` : 72 gestes, 38 sans aucun test ; les arbitrages sont de
Bastien, 2026-09-20.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Chaque geste de `docs/gestes.md` est couvert : **la logique par un test unitaire, le geste réel
par le parcours e2e**. Un seul parcours, complet, avec des cycles — il refait ce qu'un
organisateur fait sur une édition.

### Terminologie

- **Test unitaire** : un test de service sur base Isar temporaire (`test/*_service_test.dart`).
  Il vérifie la **logique** — ce qui est écrit en base, ce qui est refusé — sans écran.
- **Test e2e** : un test de widget qui monte **la vraie application** (`MarathonApp` : routeur,
  rail, pages, pods) sur une base Isar temporaire, et joue les **gestes réels** — clics, frappes,
  scans — en constatant l'écran. Il tourne sous `flutter test`, sans fenêtre ni exécutable ; ce
  n'est pas `integration_test` *(Bastien, 2026-09-20 : « tout en widget »)*.
- **Parcours** : l'unique test e2e, une suite d'**étapes** nommées par les gestes qu'elles jouent.

## Périmètre

| Cible | Détail |
|---|---|
| **Harnais e2e** `test/e2e/app_test_support.dart` | `App` : monte `MarathonApp` dans un `ProviderScope` qui remplace le client Isar par la base temporaire (C2) ; gestes `scan(code)` (touches Windows, C4), `goTo(page)`, `tap`, `type`, `submit`, `toggle`, `chooseEvent`, `pickDateTime` ; constats `see`, `dontSee`, `seeScan`, `valueOf`, `until` (la base) ; attente `tick` / `settle` (C9) ; `run(étape)` et `g(geste)` nomment l'échec (C3) |
| **Le parcours** `test/e2e/parcours_test.dart` | un seul `testWidgets`, ses étapes dans l'ordre ci-dessous (C3, C5) |
| **Tests unitaires ajoutés** | `event_service_test.dart` : `destroyPlayers` (EV-7, avec les gagnants), `generateMissingPlayers` (JO-1) ; `session_test.dart` : `Session.isOpenAt` (SE-1) ; les autres existaient (tirage, groupes, badgeage, cartes) |
| **`docs/gestes.md`** | colonne *Test* remplie pour les 72 lignes, **dans le même commit** : le test unitaire, et l'étape du parcours (« parcours, étape 6 ») |
| **Gestes injouables en widget** | marqués « recette » dans la colonne *Test*, avec la raison (voir hors périmètre) |
| **Douchette** `lib/src/ui/widgets/scanner_listener.dart` | `ScannerListener` remplace `flutter_barcode_listener` (Q4) : lit le caractère tapé, pas le code de touche ; le paquet sort du `pubspec` |
| **Défauts corrigés** (C10) | `player_edit_form.dart` (JO-11), `draw_edit_form.dart` (TI-4 / TI-5), `event_service.dart` + `draw_winner_repository.dart` (EV-7) |

### Le parcours, étape par étape

1. **Base vide** — rail grisé, infobulle, bloc central (TR-1, EV-1) ; créer l'événement A :
   champs requis (EV-3), protection allumée (EV-4), enregistrer (EV-9) ; sessions générées
   d'office (EV-8, L19) ; rail actif, événement choisi (TR-2).
2. **Joueurs, cycle 1** — 20 joueurs (JO-1) ; 10 → erreur, bouton gris (JO-1) ; billes (JO-6) ;
   bonus + / − (JO-2, JO-3) ; fiche par clic (JO-4) ; nom, bonus, badgeage manuel, enregistrer,
   annuler modifié (JO-7 à JO-13, TR-3) ; scan → fiche (JO-5) ; carte inconnue → « Carte
   invalide » (TR-4) ; scan avec l'autre sel → « Carte invalide » (CA-8).
3. **Supprimer et recréer** — protection grisée (EV-4, EV-5), *Supprimer les joueurs* : annuler
   puis confirmer (EV-7) ; *Récupérer la protection* par scan, carte sans protection → toast
   (EV-6, TR-5) ; 20 joueurs à nouveau (JO-1).
4. **Générateur** — image posée en base par le test (Q2), réglages (CA-2 à CA-4), plage 1–30
   → « Générer les joueurs supplémentaires » crée 21 à 30 (CA-5) ; aperçu rapide / PDF (CA-6) ;
   enregistrer → toast, réglages relus (CA-7) ; scan de la carte 25 → fiche (TR-4).
5. **Groupes** — créer (GR-1, GR-2), page (GR-3), scan ajoute puis « déjà dans le groupe »
   (GR-5), ajout par numéro : connu, inconnu, déjà membre (GR-10), mode suppression (GR-6),
   modifier (GR-11), annuler modifié (GR-9), scan sur la liste → fiche (GR-4), supprimer un
   groupe libre (GR-7).
6. **Sessions** — liste, couleurs, horloge, rien pour générer (SE-1, SE-7) ; scan → badgé sur
   la session ouverte, puis « déjà présent » (SE-2) ; session à venir : page (SE-3), scan refusé
   (SE-4), champ grisé (SE-8), badgeage manuel (SE-5) ; session ouverte : scan (SE-4), un absent
   qui passe présent (SE-9), par numéro : ajouter, inconnu, déjà présent (SE-8) ; mode
   suppression : *Retirer*, scan, *Supprimer* par numéro (SE-6, SE-10). Événement B, la veille
   (EV-1, TR-2) : scan → « Aucune session ouverte » (SE-2) ; retour à A.
7. **Tirages** — créer (TI-1), régler (TI-3 à TI-6), enregistrer (TI-7), rouvrir (TI-2), tirer
   (TI-8), gagnant → fiche (TI-10), lecture seule (TI-2), copier (TI-9), annuler modifié
   (TI-13), recherche et suppression absentes (TI-11, TI-12), groupe des gagnants hors liste
   mais dans le sélecteur (GR-8), suppression d'un groupe utilisé refusée (GR-7), scan → fiche.
8. **Changer les horaires** — EV-8 : nom seul → sessions intactes ; intervalle changé avec
   badgeages → modale, *Annuler les modifications* remet les champs ; *Recréer* →
   badgeages perdus ; EV-10 absent ; annuler modifié (EV-11).
9. **Cycle 2** — supprimer les joueurs (EV-7 : badgeages et gagnants perdus), recréer (JO-1),
   re-badger (SE-2), retirer (SE-6) : la base est cohérente après un tour complet.

### Hors périmètre

- **Dialogues du système** : choisir une image (CA-1), imprimer (CA-9) — injouables en widget ;
  l'image est **posée en base par le test** (Q2), les deux gestes restent « recette ». Le rendu
  PDF (CA-6) aussi (C13), et les dialogues date / heure de Flutter (C8).
- **Fermeture de la fenêtre pendant l'écriture d'un bonus** (JO-2, L15 C6) : pas de fenêtre en
  test de widget — « recette ».
- **Tests de widget par page**, isolés : le parcours est l'unique e2e *(Bastien, 2026-09-20)*.
- **`integration_test` sur l'exécutable Windows** : écarté, Q1.
- **L'aide et les tutoriels** (L12) : L12 **cite** les gestes, L18 les **couvre** — répercuté dans
  le rapport de L12.

## Critère de fin

1. `docs/gestes.md` : aucune cellule *Test* vide ; chaque ligne cite un test unitaire et / ou une
   étape du parcours, ou « recette » avec sa raison.
2. `flutter test` vert ; le parcours dure **moins d'une minute** sur le poste.
3. Un geste cassé volontairement (contrôle négatif : renvoyer `ScanInvalidCard` pour toute
   carte) fait échouer le parcours **en nommant l'étape et le geste**.
4. `flutter analyze` propre, `flutter build windows` passe.

**Constaté le 2026-09-20** : 1. les 72 lignes citent leur test ; 2. `flutter test` : 82 tests
verts, le parcours en **17 s** ; 3. toute carte rendue invalide → « Étape 2 — Joueurs, cycle 1 —
geste JO-5 : « Joueur 4 : fiche ouverte » : introuvable » ; 4. analyse propre, build passé.

## Questions déterminantes

Aucune — Q4 tranchée le 2026-09-20.

## Questions non déterminantes

Aucune — Q2 et Q3 tranchées le 2026-09-20.

## Choix d'implémentation

- **C1 — Un harnais, l'application entière** : `MarathonApp` tel quel, pas de page montée à
  part. Ce que le test voit est ce que l'organisateur voit ; le routeur et le rail sont
  couverts avec.
- **C2 — Le client Isar devient remplaçable** : `services_injector.dart` expose le provider du
  client (aujourd'hui privé, `_isarClient`) pour qu'un `ProviderScope(overrides:)` y mette
  `TestIsarClient`. Fait ; les autres changements hors `test/` sont Q4 et C10.
- **C3 — Un seul `testWidgets`, des étapes nommées** : chaque étape est une fonction
  `app.run('6 — Sessions', () async {…})` ; `app.g('SE-4')` nomme le geste en cours ; un échec
  dit « Étape 6 — Sessions — geste SE-4 : … » et imprime les textes à l'écran (critère 3). L'état vit en base et dans les pods, d'une étape à l'autre, comme en salle.
- **C4 — La douchette, ce sont des touches** : `scan(code)` tape les caractères et Entrée via
  `tester.sendKeyEvent(…, platform: 'windows')` — le chemin réel de `ScannerListener`, avec les
  touches de la cible, pas un appel au service. C'est ce qui a révélé Q4.
- **C5 — L'horloge est la vraie** : l'événement A commence 65 min avant `DateTime.now()`, ses
  sessions durent 15 min toutes les 15 min — quatre passées, la cinquième ouverte pour dix minutes
  encore, sept à venir. À l'étape 8 l'intervalle passe à 30 min : la troisième est l'ouverte. L'événement B, daté de la veille, donne « aucune session ouverte ». Pas de faux
  temps à injecter dans les pages.
- **C6 — Les gestes « non proposé » ont un test** : EV-10, SE-7, TI-11, TI-12 — le parcours
  constate l'absence du bouton ou du champ. Un geste retiré qui revient se voit.
- **C7 — La colonne *Test* cite le fichier et l'étape** : « `parcours_test.dart` (étape 6) »,
  « `event_service_test.dart` (`badgeSession`) ». Les lignes « recette » disent pourquoi.
- **C8 — Les dialogues date / heure de Flutter ne se jouent pas au clavier** : la saisie dans
  leur mode texte ne passe pas la validation en test de widget (constaté). Le parcours ouvre le
  calendrier, le referme, et pose la valeur sur `DateTimeFormField`, qui l'affiche.
- **C9 — La base répond hors horloge factice** : chaque attente passe par `tester.runAsync`
  un instant réel, puis un `pump` (`App.tick`). Isar répond par le vrai event loop ; sans cela,
  ses futurs ne se résolvent jamais sous `testWidgets`. Vérifié avant d'écrire le harnais.
- **C10 — Un défaut révélé par le parcours se corrige dans ce lot**, noté ici. Trois :
  - JO-11 — après *Enregistrer* avec badgeages manuels, la carte du joueur ne comptait pas les
    nouvelles sessions : le joueur s'écrivait avant ses liens, et c'est son écriture qui
    rafraîchit la liste. Ordre inversé (`player_edit_form.dart`).
  - TI-4 / TI-5 — les sélecteurs de groupes et de sessions de l'éditeur de tirage lisaient un pod
    à disposition automatique hors `build` ; personne ne le regarde sur la page des tirages, il
    était détruit pendant son chargement et les suggestions n'arrivaient jamais. Sur le poste la
    base répond avant la frame suivante — une course. Les listes sont lues dans `build` et passées
    aux sélecteurs (`draw_edit_form.dart`).
  - EV-7 — *Supprimer les joueurs* laissait les places de gagnants (`DrawWinner`) sans joueur ; la
    liste des tirages aurait planté sur `winner.value!`. Les gagnants partent avec les joueurs
    (`EventService.destroyPlayers`, `DrawWinnerRepository.deleteByPlayers`), testé.
- **C11 — Les débordements de mise en page ne comptent pas** : la police de test est plus haute
  et plus large que Roboto ; des blocs qui tiennent sur le poste débordent en test. Le harnais
  filtre `FlutterError` « overflowed by ». Un débordement était réel — la carte de joueur (JO-6)
  dans une grille qui répartit la largeur, constaté par Bastien à la recette : les cartes ont
  maintenant une taille fixe (200 × 176 : ligne du nom dense, trois lignes compactes) et se rangent dans un `Wrap`. Deux autres endroits
  débordent avec la police de test seulement, à regarder en recette : la carte de session
  (SE-1, 155 × 125) et la ligne « n joueurs / Générer les joueurs supplémentaires » du
  générateur (CA-5, panneau de 420 px).
- **C15 — Retouches de recette sur la carte de joueur** *(Bastien, 2026-09-20)* : hauteur
  réduite (176 px), et la bille du numéro **grise sans jeton** — comme les compteurs. JO-6 mis à
  jour, le parcours le constate (étape 2).
- **C12 — Une animation sans fin ne bloque pas** : `tick` borne `pumpAndSettle` à deux secondes
  d'horloge et passe (l'éditeur de tirage tourne un indicateur pendant son chargement).
- **C13 — Le rendu PDF (CA-6) reste en recette** : `PdfPreview` passe par le module natif
  d'impression, absent en test — il tourne sans fin. Le parcours joue la bascule seulement.
- **C14 — La base se ferme dans le test, pas dans `tearDownAll`** : après un échec, une lecture
  Isar en suspens dans l'horloge factice ne rend jamais la main et `tearDownAll` attend trois
  minutes. Le harnais démonte l'application, laisse finir hors horloge, puis ferme (borné à 10 s).

## Questions tranchées

- **Q1 — Tests de widget ou exécutable Windows ?** → **tout en widget** ; **un seul parcours,
  complet, avec des cycles** : créer l'événement, créer les joueurs, les supprimer et recréer,
  en ajouter par le générateur de cartes, groupes créés et supprimés, badger, dé-badger, passage
  par l'éditeur de carte, mode manuel, mode suppression, effet du scan sur tous les écrans
  *(Bastien, 2026-09-20)*.
- **Partage des rôles** — les tests unitaires couvrent la **logique**, les tests e2e les
  **gestes réels** *(Bastien, 2026-09-20)*.
- **Ordre** — L15 puis L19 sont livrés d'abord ; L18 part d'une base propre *(Bastien, 2026-09-20)*.
- **Q2 — L'image de fond des cartes ?** → **posée en base par le test** ; le sélecteur d'image
  (CA-1) reste hors test, « recette » *(Bastien, 2026-09-20)*.
- **Q3 — La douchette simulée passe-t-elle le tampon de `BarcodeKeyboardListener` ?** →
  **simuler les frappes de douchette** (C4), d'un trait d'abord ; si le tampon de 100 ms les
  refuse, **`tester.runAsync` avec une courte attente réelle** *(Bastien, 2026-09-20)*. Le
  rapport dira lequel a marché.
- **Q4 — Sous Windows, une carte protégée ne se scanne pas : que fait-on ?** Constaté par le
  parcours (étape 2, JO-5) : `flutter_barcode_listener` lit, sous Windows, le **code de touche
  virtuelle**, pas le caractère tapé — `a` → `A`, `-` → `½` ; un code `ab12cd34-4` arrive
  `AB12CD34½4`, « Carte invalide ». Les cartes sans protection (chiffres seuls) passent, d'où
  l'édition 2025 sans incident. Jamais scanné en vrai avec une protection *(Bastien)*. →
  **(a) un écouteur maison**, `ScannerListener` sur `HardwareKeyboard` (`KeyDownEvent.character`,
  touches groupées à 100 ms, Entrée), à la place du paquet, dans `PlayerSessionScanner` et la
  boîte *Récupérer la protection* ; le paquet sort du `pubspec`. Le parcours le vérifie avec des
  touches Windows *(Bastien, 2026-09-20)*. Q3 se lit avec : les frappes d'un trait passent, sans
  `runAsync` particulier — le harnais attend la base, pas la douchette (C9).

## Suggestions

- **Un contrôle mécanique de la colonne *Test*** : un test qui lit `docs/gestes.md` et échoue
  si une cellule *Test* est vide, ou cite un fichier de test absent. La règle « chaque geste a
  un test » tiendrait alors sans relecture (méthode, partie I, § 7).
- **`google_fonts` en test** : quatre lignes d'erreur à chaque lancement (Roboto absent des
  assets, chargement à la volée coupé). Sans effet sur le rendu ni sur le résultat. Embarquer les
  polices dans les assets les ferait taire — et rendrait l'application indépendante du réseau au
  premier lancement.
- **Textes** : « Nom is required » (`data_playerGroup_error_name_required`, fr) — vu en passant
  (GR-2) ; corrigé sur demande de Bastien, avec `data_draw_error_name_required` (« Le nom est
  requis », comme les autres).
- **Deux ajouts rapides par numéro** sur la page d'un groupe (GR-10), sans attendre que le
  premier s'affiche : le parcours a montré un compte qui revient en arrière quand il enchaîne
  sans pause. Non reproduit en jouant au rythme d'une personne (le parcours attend chaque
  bille). À garder en tête si un compte de membres paraît faux.
