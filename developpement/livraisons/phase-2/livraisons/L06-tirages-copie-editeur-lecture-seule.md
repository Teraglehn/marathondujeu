# L06 — Tirages : copie d'un tirage, éditeur revu, lecture seule des tirages effectués

Statut : **livré** (ouvert le 2026-09-19, attaqué le 2026-09-19, livré le 2026-09-19) · Ne dépend d'aucun lot.
Sorti de L02 (L02 Q2).

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Trois volets sur la page des tirages (Bastien, 2026-09-19) :

1. **Copier un tirage** : depuis un tirage, en créer un second qui reprend son paramétrage et
   **exclut ses gagnants** — le geste normal pour « refaire » un tirage.
2. **Revoir l'éditeur latéral** d'un tirage.
3. **Lecture seule des tirages effectués** : un tirage qui a désigné ses gagnants ne se modifie
   plus et ne se retire plus au sort par mégarde.

### Terminologie

- **Tirage effectué** : un tirage qui a été **lancé** — une fois, jamais deux (Bastien,
  2026-09-19). Il porte la date de son lancement, `Draw.drawnAt` (C1), même s'il n'a désigné
  aucun gagnant.
- **Tirage préparé** : enregistré, jamais lancé. Il se modifie et se lance.

## État du code (constats 2026-09-19)

- `DrawService.createDrawFromDraw` existe, n'est branchée nulle part, oublie `requiredPlayers` et
  `winnerCount`, et ne sauvegarde pas.
- **Un tirage existant ne s'ouvre pas** : `editor.editDraw` n'est appelé nulle part ; la liste
  n'a que *supprimer*. Seul un tirage neuf passe par l'éditeur.
- **Toute sauvegarde relance le tirage** : `Draws.save` → `calculateDraw` → `save`. Un seul
  bouton, *Sauvegarder et tirer au sort*.
- L'éditeur sélectionne les joueurs exclus / requis **par groupes**, mais `Draw` ne garde que les
  **joueurs** résolus : à la réouverture, les groupes choisis ne se retrouvent pas.
- `updatePlayerCount()` est appelé dans `build` : une requête asynchrone et un `setState` à
  chaque reconstruction.
- `DrawService.getWinner` : si aucun joueur éligible n'a de jeton, `lots` est vide et
  `nextInt(0)` lève une exception (L10, suggestion).

## Périmètre

| Cible | Détail |
|---|---|
| `Draw` | `drawnAt` (`DateTime?`, C1), deux liens `excludedGroups`, `requiredGroups` (C2) et `winnersGroup` (C9). `excludedPlayers` garde les exclusions individuelles (gagnants d'un tirage copié) ; `requiredPlayers` reste, inchangé |
| `DrawService` | `createDrawFromDraw` complétée : tout le paramétrage (groupes, joueurs, sessions, min / max, nombre de gagnants), groupe des gagnants de la source ajouté aux groupes exclus (C9), **non enregistrée** : l'éditeur s'ouvre dessus (Q2) ; éligibilité = groupes résolus au moment du tirage + joueurs (C2) ; `getWinner` sans jeton → aucun gagnant, pas d'exception (C6) ; `calculateDraw` refuse un tirage déjà lancé et pose `drawnAt` (C4) |
| Liste des tirages | par tirage : **Copier** (C3), **Ouvrir** (clic sur la ligne) ; **plus de suppression** (Q1) ; la bille porte l'**identifiant** du tirage, celui du nom par défaut ; un tirage effectué est marqué (C4) |
| Éditeur (`draw_edit_form.dart`) | s'ouvre sur un tirage existant avec ses choix (C2) ; deux boutons, **Enregistrer** et **Tirer au sort** (C5) ; en lecture seule pour un tirage effectué (C4) ; le compteur de joueurs se recalcule sur changement, pas dans `build` ; joueurs exclus individuellement affichés en nombre (C3) |
| Pods | `Draws.save` n'appelle plus `calculateDraw` ; `Draws.draw(item)` le fait (C5) |
| Tests | `createDrawFromDraw` copie tout et exclut les gagnants ; éligibilité avec groupes ; `getWinner` sans jeton ; un tirage effectué n'est pas recalculé par `save` |
| Textes | *Copier*, *Tirer au sort*, *Tiré le …*, *n joueurs exclus (gagnants de « … »)*, fr/en |

### Hors périmètre

- L'algorithme du tirage (poids par jetons) : inchangé.
- L'affichage des gagnants (L04, livré).
- Un historique des relances : il n'y en a pas, un tirage ne se lance qu'une fois (C1).
- L'aide de la page (L12).

## Critère de fin

Sur la base de test, un événement avec des joueurs badgés et deux groupes :

1. Créer un tirage A avec un groupe exclu et une session requise, *Enregistrer* : A apparaît dans
   la liste **préparé**, rouvrable, ses choix retrouvés. *Tirer au sort* : A a ses gagnants et
   sa date.
2. Rouvrir A : champs grisés, ni *Enregistrer* ni *Tirer au sort* ; *Copier* et *Fermer* seulement.
3. *Copier* A : l'éditeur s'ouvre sur « A - copie », non enregistrée, mêmes choix et « n joueurs
   exclus individuellement ». *Annuler* : rien dans la liste. *Tirer au sort* : aucun gagnant de
   A ne gagne, sur dix copies.
4. Aucun bouton ne supprime un tirage, préparé ou effectué (Q1).
5. Un tirage dont aucun joueur éligible n'a de jeton : *Tirer au sort* donne zéro gagnant, sans
   erreur ; le tirage est **effectué** quand même — daté, en lecture seule (C1).
6. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-19** :
1–3, 5. Recette Bastien : « ok tu peux livrer le L06 », après treize retouches (voir la recette).
Le lancement unique, la copie et l'urne vide sont aussi testés sur base.
4. Plus aucun bouton de suppression (Q1).
6. `flutter analyze` : `No issues found!` ; 37 tests verts (7 nouveaux) ; `flutter build windows`
construit.
Écarts : pas de suppression de tirage (Q1) ; copie ouverte dans l'éditeur sans enregistrement
(Q2) ; groupe des gagnants (C9) ; noms « Tirage N°n » (C3) ; grille de sessions (C10) ; joueurs
sans jeton hors de l'urne et compteur de jetons (C11) ; titres des éditeurs latéraux (C12).

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1, Q2 tranchées le 2026-09-19.

## Choix d'implémentation

- **C1 — Un tirage est effectué s'il a été lancé** : `Draw.drawnAt` posé par `calculateDraw`
  (temps 1 du § 12). Un tirage sans gagnant (personne d'éligible) est effectué quand même : le
  geste a eu lieu, on le copie pour recommencer. Les tirages existants, sans date mais avec des
  gagnants, sont effectués : `isDrawn = drawnAt != null || winners non vides`. **Pas de
  migration** : inventer une date serait une valeur plausible (§ 8) ; ils s'affichent « Tiré »
  sans date.
- **C2 — `Draw` garde les groupes choisis**, pas seulement les joueurs résolus : `excludedGroups`
  et `requiredGroups` (liens Isar, temps 1 du § 12). Les groupes sont **résolus au moment du
  tirage** — un joueur qui rejoint un groupe entre la préparation et le tirage est pris en
  compte. Éligibles = (joueurs des groupes requis ∪ joueurs requis, ou tous) − joueurs des
  groupes exclus − joueurs exclus, puis les filtres de sessions comme aujourd'hui.
- **C3 — La copie reprend tout et exclut les gagnants** de la source, par leur **groupe** (C9)
  ajouté aux groupes exclus, et **ouvre l'éditeur sans l'enregistrer** (Q2). Aucun défaut de
  formulaire ne s'applique à une copie : les défauts (dernière session requise) sont posés à la
  création d'un tirage neuf, dans `EditorPod.newDraw` (Bastien, 2026-09-19). Nom : « Tirage N°n », n = plus grand identifiant + 1 — pour un tirage neuf comme pour
  une copie (Bastien, 2026-09-19 ; `DrawService.nextName`). Le formulaire est **clé sur son tirage**
  (`ObjectKey`) : ouvrir la copie depuis un tirage effectué recrée l'éditeur.
- **C4 — Un tirage effectué s'ouvre en lecture seule** : mêmes champs, désactivés, sans
  *Enregistrer* ni *Tirer au sort* ; *Copier* et *Fermer*. Dans la liste, « Tiré le … » et un
  cadenas. Aucun chemin ne relance `calculateDraw` sur lui : le service **refuse** un tirage déjà
  daté (garde, testée).
- **C5 — Deux boutons** : *Enregistrer* sauvegarde sans tirer (`Draws.save`) ; *Tirer au sort*
  sauvegarde puis tire (`Draws.draw`), après une **confirmation** qui rappelle le nombre de
  joueurs éligibles et de gagnants. `utils_button_save_and_draw` disparaît.
- **C6 — `getWinner` sans jeton** : retourne `null`, le tirage s'arrête avec les gagnants déjà
  désignés. Reprise de la suggestion de L10.
- **C7 — Le compteur de joueurs éligibles** se recalcule dans les `onChanged` des champs et au
  chargement, plus dans `build`.
- **C8 — Pas de test de widget** : le service est testé (copie, éligibilité, garde), l'éditeur se
  constate à la recette — comme L04, L10, L11, L05.
- **C9 — Le lancement crée le groupe « Gagnants du tirage « <nom> » »** (Bastien, 2026-09-19) :
  un `PlayerGroup` de l'événement avec les gagnants, lié au tirage (`Draw.winnersGroup`).
  Visible dans les groupes, il sert d'exclusion à la copie (C3) et à tout autre tirage. Pas de
  groupe si le tirage n'a désigné personne.
- **C10 — Le sélecteur de sessions est une grille** (recette, 2026-09-19) : toutes les sessions de
  l'événement, par heure de début, en cartes (numéro, heure) colorées quand elles sont choisies ;
  la recherche par numéro reste. `MultiSearchSelector` gagne un `viewBuilder` optionnel — les
  autres sélecteurs gardent leur liste.
- **C11 — Un joueur sans jeton est hors de l'urne** (Bastien, 2026-09-19) : retiré des
  éligibles, au compteur comme au tirage. L'éditeur affiche deux compteurs, joueurs et **jetons
  dans l'urne**, avec une ligne d'aide.
- **C12 — Titre des éditeurs latéraux** (Bastien, 2026-09-19) : « Créer / Modifier un … », et
  « Consulter un tirage » pour un tirage effectué, avec une croix pour fermer — les quatre
  tiroirs. Hors périmètre initial.
- **C13 — Sélecteurs en lecture seule** : un tirage effectué laisse **ouvrir** les sélecteurs de
  groupes et de sessions pour lire les choix, sans rien cocher (`MultiSearchSelector.readOnly`).
  Actions du formulaire et de la liste passées par `drawServiceProvider` : `drawsProvider()` sans
  événement n'est regardé par personne et son `ref` meurt entre deux attentes.

## Questions tranchées

- **Q1 — Supprimer un tirage effectué ?** → **aucune suppression de tirage**, effectué ou
  préparé : le bouton disparaît de la liste et de l'éditeur. *(Bastien, 2026-09-19 — d'abord
  (a) avec confirmation, revu à la recette le même jour.)*
- **Q2 — Copier ouvre l'éditeur, ou crée directement ?** → **(a) ouvre l'éditeur** sur la
  copie non enregistrée, comme un tirage neuf. *(Bastien, 2026-09-19 — d'abord (b), revu à la
  recette le même jour.)*
- **Un tirage ne se lance qu'une fois** → règle actée, portée par C1 et C4. *(Bastien,
  2026-09-19)*

## Suggestions

- **Afficher les joueurs exclus un par un** dans l'éditeur, avec retrait possible : demandé par
  personne, écarté du périmètre (C3).
