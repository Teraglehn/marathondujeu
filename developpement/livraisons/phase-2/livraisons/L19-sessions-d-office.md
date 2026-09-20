# L19 — Sessions générées d'office

Statut : **livré** le 2026-09-20 (ouvert le 2026-09-20) · Ne dépend d'aucun lot. **L18** en dépend : le
parcours teste EV-8 dans sa forme finale, ce lot passe avant.

> Numérotation unique : une seule séquence Q1, Q2, … sur tout le rapport ; les choix d'exécution
> en C1, C2, …

## Objet

La coche *Générer les sessions (supprime les sessions existantes)* disparaît. Les sessions
suivent les paramètres de l'événement sans geste de l'organisateur *(Bastien, 2026-09-20)* :

| Cas | Effet |
|---|---|
| Création | les sessions sont générées, toujours ; rien à supprimer |
| Modification, paramètres de session inchangés | les sessions restent |
| Modification, paramètres changés, **aucun badgeage** | les sessions sont recréées, sans demander |
| Modification, paramètres changés, **des badgeages** | modale : *Recréer* (sessions et n badgeages perdus) ou *Annuler les modifications* des paramètres |

Les **paramètres de session** : début, fin, durée, intervalle. Le nom et la protection (EV-4)
n'en font pas partie.

## Périmètre

| Cible | Détail |
|---|---|
| `event_service.dart` | `save(event, {regenerateSessions})` : un événement **neuf** génère toujours ; un existant recrée si `regenerateSessions` — supprimer puis générer |
| `dirty_aware.dart` | `eventSessionsChanged(event, …)` : les quatre paramètres à l'écran contre l'objet ouvert ; `eventFormIsDirty` perd `generateSessions` |
| `event_edit_form.dart` | la coche disparaît ; à *Enregistrer* sur un existant, paramètres changés et badgeages > 0 → modale ; *Annuler les modifications* remet les quatre champs à leur valeur enregistrée et laisse l'éditeur ouvert |
| `events.dart` (pod) | relaie `regenerateSessions` |
| Textes ARB fr / en | titre et corps de la modale, ses deux boutons ; les textes de la coche partent |
| Tests | `event_service_test.dart` : neuf → sessions ; existant sans changement → intactes ; recréées → badgeages perdus. `forms_dirty_test.dart` : `eventSessionsChanged`, `generateSessions` retiré |
| `docs/gestes.md` | EV-8 réécrit, EV-9 et EV-11 sans la coche, SE-7 renvoie toujours à EV-8 ; **même commit** |
| L18 | étapes 1 et 8 ajustées à la nouvelle forme d'EV-8 |

### Hors périmètre

- Le nombre de sessions affiché avant d'enregistrer (« 96 sessions de 15 min ») : utile, pas
  demandé — voir Suggestions.
- La page des sessions (SE-7) reste sans génération.

## Critère de fin

1. Créer un événement → la page des sessions en montre, sans avoir rien coché.
2. Modifier le nom seul → les sessions et leurs badgeages sont intacts.
3. Changer l'intervalle sans badgeage → sessions recréées, pas de modale.
4. Changer l'intervalle avec des badgeages → modale ; *Annuler les modifications* remet les
   champs, l'éditeur reste ouvert, rien n'est écrit ; *Recréer* recrée, les badgeages sont perdus.
5. `flutter analyze` propre, `flutter test` vert, `flutter build windows` passe.

## Questions déterminantes

Aucune.

## Questions non déterminantes

Aucune.

## Choix d'implémentation

- **C1 — Le service décide pour un événement neuf** : `save` génère dès que l'événement n'existait
  pas, quel que soit l'appelant. La règle « toujours des sessions » ne dépend pas du formulaire.
- **C2 — Le formulaire décide pour un existant** : c'est lui qui a les valeurs avant et après ;
  le service reçoit `regenerateSessions` et ne relit pas la base pour comparer.
- **C3 — La comparaison est une fonction pure** (`eventSessionsChanged`, à côté des `…IsDirty`) :
  testée sans écran.
- **C4 — *Annuler les modifications* ne ferme pas l'éditeur** : les quatre champs reprennent leur
  valeur enregistrée, le nom et la protection modifiés restent — l'organisateur garde la main.
- **C5 — La modale dit le nombre de badgeages** (`countBadges`, L15) : « Les horaires ont changé :
  les sessions seront recréées et n badgeages perdus. »

## Questions tranchées

- **La coche disparaît, les sessions suivent les paramètres** ; sans badgeage on recrée sans
  demander ; avec, on confirme ou on annule les modifications *(Bastien, 2026-09-20)*.

## Suggestions

- Afficher sous les champs le nombre de sessions que les paramètres donnent, avant d'enregistrer.
