# L18 — Couverture des gestes par les tests

Statut : **à faire** (ouvert le 2026-09-20) · Dépend de **L15** et **L19** (livrés d'abord — Bastien,
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
| **Harnais e2e** `test/e2e/app_test_support.dart` | monte `MarathonApp` dans un `ProviderScope` qui remplace le client Isar par la base temporaire (C2) ; helpers `scan(code)` (frappes de douchette, C4), `goTo(page)`, `expectScanStatus(texte)` |
| **Le parcours** `test/e2e/parcours_test.dart` | un seul `testWidgets`, ses étapes dans l'ordre ci-dessous (C3, C5) |
| **Tests unitaires manquants** | la logique sans test aujourd'hui : `destroyPlayers` (EV-7), bornes de `generateMissingPlayers` (JO-1), `Session.isOpenAt` (SE-1) ; les autres existent (tirage, groupes, badgeage, cartes) |
| **`docs/gestes.md`** | colonne *Test* remplie pour les 72 lignes, **dans le même commit** : le test unitaire, et l'étape du parcours (« parcours, étape 6 ») |
| **Gestes injouables en widget** | marqués « recette » dans la colonne *Test*, avec la raison (voir hors périmètre) |

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
6. **Sessions** — liste, couleurs, horloge (SE-1) ; scan → badgé sur la session ouverte, puis
   « déjà présent » (SE-2) ; page (SE-3) ; scan session ouverte / non ouverte (SE-4) ; badgeage
   manuel (SE-5) ; par numéro : ajouter, inconnu, animation (SE-8, SE-9) ; mode suppression :
   *Retirer*, *Supprimer* par numéro (SE-6, SE-10). Événement B, la veille (TR-2) : scan →
   « Aucune session ouverte » (SE-2) ; retour à A.
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
  l'image est **posée en base par le test** (Q2), les deux gestes restent « recette ».
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

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q2 et Q3 tranchées le 2026-09-20.

## Choix d'implémentation

- **C1 — Un harnais, l'application entière** : `MarathonApp` tel quel, pas de page montée à
  part. Ce que le test voit est ce que l'organisateur voit ; le routeur et le rail sont
  couverts avec.
- **C2 — Le client Isar devient remplaçable** : `services_injector.dart` expose le provider du
  client (aujourd'hui privé, `_isarClient`) pour qu'un `ProviderScope(overrides:)` y mette
  `TestIsarClient`. Seul changement de code hors `test/`.
- **C3 — Un seul `testWidgets`, des étapes nommées** : chaque étape est une fonction
  `step('6 — Sessions', () async {…})` qui trace son nom ; un échec dit l'étape et le geste
  (critère 3). L'état vit en base et dans les pods, d'une étape à l'autre, comme en salle.
- **C4 — La douchette, ce sont des touches** : `scan(code)` tape les caractères et Entrée via
  `tester.sendKeyEvent` — le chemin réel de `BarcodeKeyboardListener`, pas un appel au service.
- **C5 — L'horloge est la vraie** : l'événement A commence une heure avant `DateTime.now()`,
  ses sessions durent 15 min toutes les 15 min — il y a toujours une session ouverte, une passée,
  une à venir. L'événement B, daté de la veille, donne « aucune session ouverte ». Pas de faux
  temps à injecter dans les pages.
- **C6 — Les gestes « non proposé » ont un test** : EV-10, SE-7, TI-11, TI-12 — le parcours
  constate l'absence du bouton ou du champ. Un geste retiré qui revient se voit.
- **C7 — La colonne *Test* cite le fichier et l'étape** : « `parcours_test.dart` (étape 6) »,
  « `event_service_test.dart` (`badgeSession`) ». Les lignes « recette » disent pourquoi.

## Questions tranchées

- **Q1 — Tests de widget ou exécutable Windows ?** → **tout en widget** ; **un seul parcours,
  complet, avec des cycles** : créer l'événement, créer les joueurs, les supprimer et recréer,
  en ajouter par le générateur de cartes, groupes créés et supprimés, badger, dé-badger, passage
  par l'éditeur de carte, mode manuel, mode suppression, effet du scan sur tous les écrans
  *(Bastien, 2026-09-20)*.
- **Partage des rôles** — les tests unitaires couvrent la **logique**, les tests e2e les
  **gestes réels** *(Bastien, 2026-09-20)*.
- **Ordre** — L15 est livré d'abord ; L18 part d'une base propre *(Bastien, 2026-09-20)*.
- **Q2 — L'image de fond des cartes ?** → **posée en base par le test** ; le sélecteur d'image
  (CA-1) reste hors test, « recette » *(Bastien, 2026-09-20)*.
- **Q3 — La douchette simulée passe-t-elle le tampon de `BarcodeKeyboardListener` ?** →
  **simuler les frappes de douchette** (C4), d'un trait d'abord ; si le tampon de 100 ms les
  refuse, **`tester.runAsync` avec une courte attente réelle** *(Bastien, 2026-09-20)*. Le
  rapport dira lequel a marché.

## Suggestions

- **Un contrôle mécanique de la colonne *Test*** : un test qui lit `docs/gestes.md` et échoue
  si une cellule *Test* est vide, ou cite un fichier de test absent. La règle « chaque geste a
  un test » tiendrait alors sans relecture (méthode, partie I, § 7).
