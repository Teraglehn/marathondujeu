# L21 — Corrections : un numéro par tirage dans l'événement ; fermer un événement

Statut : **livré le 2026-09-20** (rédigé, rattaché à la phase 2, Q1 tranchée, attaqué et livré le 2026-09-20) · Ne dépend d'aucun lot ouvert.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

Deux corrections *(Bastien, 2026-09-20)* :

1. **Un tirage a un numéro dans son événement** — 1, 2, 3… dans l'ordre de création — et c'est
   lui que l'écran montre et que le nom par défaut reprend, **pas l'identifiant de base**. Après
   l'ouverture d'un fichier de sauvegarde (L09), les identifiants changent : la bille de la liste
   et le nom « Tirage N°n » ne se correspondaient plus, et le compteur des noms mélangeait tous
   les événements.
2. **Un événement se ferme** : depuis son éditeur, *Fermer l'événement* le supprime de la base
   avec tout ce qui s'y rattache. S'il **n'a pas de fichier de sauvegarde**, une confirmation le
   dit avant. La signalétique parle de **fermer**, pas de supprimer : avec son fichier, l'événement
   se rouvre.

### Terminologie

- **Numéro de tirage** (`Draw.number`) : le rang du tirage dans son événement. Stable, jamais
  réattribué, il voyage dans le fichier de sauvegarde. L'identifiant Isar (`Draw.id`) ne se voit
  plus nulle part.
- **Fermer un événement** : le retirer de la base avec ses données. Le fichier de sauvegarde, s'il
  existe, **reste** ; *Ouvrir un fichier de sauvegarde* (EV-13) le ramène.
- **Sauvegardé** : l'événement a un fichier de sauvegarde **et** il est à jour (les écritures en
  attente sont faites, sans erreur) — voir C4.

## État du code (constats 2026-09-20)

- La liste des tirages montre `draw.id` dans sa bille ; `DrawService.nextName` fait
  « Tirage N°{max id + 1} » sur **tous** les tirages de la base, tous événements confondus.
- Le fichier de sauvegarde (`BackupFormat`, format 1) porte les tirages par rang, sans numéro ;
  à l'ouverture, ils reçoivent de nouveaux `id`.
- Le nom du groupe de gagnants reprend le nom du tirage (« Gagnants du tirage « Tirage N°1 » ») :
  il ne change pas.
- EV-10 (`docs/gestes.md`) : le tiroir ouvre l'éditeur d'événement avec `allowRemove: false` ; le
  bouton *Supprimer* n'est jamais proposé. `EventService.delete` ne supprime que l'événement, pas
  ses données — il laisserait des orphelins.
- `BackupService._deleteEvent` (L09) supprime déjà un événement **et tout ce qui s'y rattache**,
  dans une transaction ouverte : gagnants, tirages, groupes, sessions, joueurs, événement. C'est
  la suppression à réutiliser.
- `BackupService.pending` et `flush()` disent si des écritures attendent et les font ; `onError`
  signale un échec d'écriture.
- Le schéma est en production : `Draw.number` est un **ajout** (méthode, partie I, § 12).

## Périmètre

| Cible | Détail |
|---|---|
| `Draw.number` | champ ajouté, `int`, 0 tant que non attribué ; `DrawService.nextNumber(event)` = max des numéros de l'événement + 1 ; `createDraw` et `createDrawFromDraw` le posent, et nomment « Tirage N°{number} » (C1) |
| `IsarClient.migrateDrawNumbers` | à l'ouverture de la base, les tirages sans numéro en reçoivent un, par événement, dans l'ordre des `id` — une fois, comme les migrations existantes (C2) |
| `BackupFormat` | le numéro voyage dans le fichier (`draws[].number`) ; un fichier sans numéro (écrit avant ce lot) → le rang + 1 (C3) — le format reste `1` : un champ en plus se lit, il ne se refuse pas |
| Liste des tirages | la bille montre `number` ; l'ordre de la liste suit le numéro |
| `EventService.destroyEvent` | la suppression en cascade, déplacée depuis `BackupService._deleteEvent` et rendue publique ; l'import de L09 l'appelle |
| Éditeur d'événement et liste | pour un événement existant, un bouton **Fermer l'événement** (icône `logout`, couleur d'erreur) en bas à gauche de l'éditeur, et la même icône au bout de chaque ligne de la liste (Bastien, 2026-09-20) — un seul dialogue, `closeEvent` (`close_event_dialog.dart`) ; toujours une modale (Q1) : sans fichier, ou fichier pas à jour → « Cet événement n'est pas sauvegardé… » : *Fermer quand même* / *Annuler* ; sauvegardé → « Fermer « … » ? Son fichier de sauvegarde reste. » : *Fermer* / *Annuler*. Après : l'éditeur se ferme, l'événement sélectionné est vidé, toast « Événement « … » fermé » — avec le chemin du fichier quand il y en a un (C5) |
| Textes | fr/en : le bouton, la modale, le toast ; l'aide de la page des événements (pas 4 : « … ou le fermer ») ; le guide ne change pas |
| `docs/gestes.md` | EV-10 réécrit (*Fermer l'événement*, ses variantes), TI-1 / TI-2 / TI-9 (numéro), EV-13 (numéros conservés) |
| Tests | `draw_service_test` : numéros par événement, copie, nom ; `isar_client` : migration ; `backup_service_test` : le numéro fait l'aller-retour, un fichier sans numéro en reçoit ; `event_service_test` : `destroyEvent` ne laisse rien ; parcours e2e : fermer un événement non sauvegardé (modale) puis un sauvegardé (direct), la liste et la base après |

### Hors périmètre

- Renuméroter des tirages existants autrement que par l'ordre des `id`.
- Une corbeille ou un « rouvrir » depuis l'application : le fichier de sauvegarde est la
  corbeille.
- Supprimer le fichier de sauvegarde à la fermeture : jamais.
- Un numéro pour les groupes : ils ont un nom, rien ne les cite par identifiant.

## Critère de fin

1. Deux événements, deux tirages chacun : les billes disent 1 et 2 dans chaque événement, les
   noms par défaut « Tirage N°1 » et « Tirage N°2 » dans chacun.
2. Un événement sauvegardé, base vidée, fichier ouvert : les tirages gardent leurs numéros et leurs
   noms ; un tirage créé ensuite prend le numéro suivant.
3. Une base d'avant ce lot (tirages sans numéro) : à l'ouverture, chaque événement voit ses
   tirages numérotés dans l'ordre de création.
4. *Fermer l'événement* sur un événement **sans** fichier → modale ; *Fermer quand même* →
   l'événement et ses joueurs, sessions, groupes, tirages, gagnants ont disparu de la base, la
   liste ne le montre plus, plus d'événement sélectionné.
5. Sur un événement **avec** fichier → la modale courte, *Fermer* → toast avec le chemin ; le
   fichier est intact ; l'ouvrir ramène l'événement entier.
6. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

**Constaté le 2026-09-20** : 1. `draw_service_test` (numéro de tirage) : A → 1, 2 ; B → 1 ; copie → 3 ;
noms « Tirage N°n » ; 2. étape 11 du parcours : après base vidée et fichier ouvert, le tirage porte
le numéro 1 dans sa bille ; 3. `draw_service_test` (migration) : deux événements, tirages sans
numéro numérotés dans l'ordre de création à la suite des numéros existants, sans effet une
seconde fois ; 4. étape 11 : sans fichier → modale, *Annuler* ne ferme rien, *Fermer quand même*
→ les six collections vides, liste vide ; 5. avec fichier, depuis la liste → modale courte,
*Fermer* → toast avec le chemin, fichier intact, base vide ; 6. analyse propre, 96 tests verts,
build passé.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune — Q1 tranchée le 2026-09-20.

## Choix d'implémentation

- **C1 — Le numéro se pose à la création, dans le service**, jamais à l'écran : `createDraw` et
  `createDrawFromDraw` lisent les tirages de l'événement et prennent le suivant. Deux tirages
  créés sans enregistrer le premier prendraient le même numéro : l'éditeur enregistre l'un avant
  d'ouvrir l'autre (un seul tiroir), le cas ne se présente pas.
- **C2 — Migration à l'ouverture**, sans effet une fois faite : le modèle de
  `migratePlayerNumbers` et `migratePlayerGroupKinds`.
- **C3 — Le format de fichier reste `1`** : lire un champ absent avec un défaut ne casse pas les
  fichiers écrits avant ; le refus de version est pour les changements qui ne se lisent pas.
- **C4 — « Sauvegardé » se vérifie au moment de fermer** : chemin présent → `flush()` d'abord ;
  une écriture en erreur (dossier disparu, disque plein) vaut « pas sauvegardé » → modale.
- **C5 — Le toast nomme le fichier** : « Événement « X » fermé — son fichier de sauvegarde :
  C:\…\X.marathon.json ». Sans fichier : « Événement « X » fermé ».
- **C6 — Une seule cascade** : `EventService.destroyEvent`, appelée par la fermeture et par le
  remplacement à l'ouverture d'un fichier (L09) — le même code, testé une fois.
- **C7 — La liste des tirages se trie par numéro** (`getByEventIdStream`, `getByEventId`) : l'ordre
  de création, quel que soit l'`id`.

### Défauts de L09 révélés par le parcours, corrigés ici

- **Le cliché n'était pas atomique** : `BackupService.snapshot` enchaînait ses requêtes hors
  transaction ; entre deux, une fermeture ou un remplacement pouvait vider l'événement, et le
  fichier sortait à moitié vide (constaté : joueurs présents, tirages absents). Le cliché se lit
  maintenant dans **une transaction** (`isar.txn`).
- **Deux écritures pouvaient se chevaucher** sur le même fichier (le service et la fermeture,
  même `.tmp` → « le processus ne peut pas accéder au fichier »). Les écritures sont
  **sérialisées** dans le service (`_serialized`) ; la fermeture passe par `writeNow(event)`,
  qui rend vrai si l'écriture est faite.

## Questions tranchées

- **Q1 — Confirmer aussi quand l'événement est sauvegardé ?** → **oui, toujours une modale** :
  courte quand le fichier est à jour (« Fermer « … » ? Son fichier de sauvegarde reste. »),
  explicite sinon (« Cet événement n'est pas sauvegardé… »). Écarté : la fermeture directe —
  un geste qui vide l'écran mérite un clic de plus. *(Bastien, 2026-09-20)*

## Suggestions

- **Une corbeille** : fermer un événement sans fichier pourrait écrire un fichier de sauvegarde
  dans `%APPDATA%` avant de supprimer — la modale deviendrait inutile. Plus tard, si la modale
  gêne.
