import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:marathondujeu/src/ui/widgets/fields/multi_search_selector.dart';
import 'package:flutter/material.dart';

class SessionMultiSelector extends MultiSearchSelector<Session> {

  SessionMultiSelector({
    super.initialValue,
    super.label,
    super.labelStyle,
    super.anchorBuilder,
    super.onChanged,
    super.allowRemove,
    super.autovalidateMode,
    super.onSaved,
    super.validator,
    super.enabled,
    super.readOnly,
    super.restorationId,
    super.key,
    required Event event,
    List<Session>? sessions,
  }) : super(
    getSuggestions: (ref, keyword) async {
      List<Session> filteredSession = sessions ?? await ref.watch(sessionsProvider(eventId : event.id).future);
      // Toutes les sessions, dans l'ordre : la grille les montre d'un coup.
      return (filteredSession
        .where((element) => element.number.toString().contains(keyword.trim()))
        .toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime)));
    },
    viewBuilder: (suggestions) => SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Wrap(spacing: 8, runSpacing: 8, children: suggestions.toList()),
    ),
    itemBuilder: (context, state, value, changeValue, switchValue) => 
      ListTile(
        title: value.isEmpty ? Text(S.of(context).widget_playerGroupSelector_selectTitle) : Text(value.map((v) => v.number.toString()).join(", ")), 
        contentPadding: const EdgeInsets.all(0),
      ),
    // Une carte par session : numéro et heure de début, colorée quand elle est choisie.
    suggestionBuilder: (ref, context, state, value, changeValue, switchValue) {
      final selected = state.value?.contains(value) ?? false;
      final scheme = Theme.of(context).colorScheme;
      return SizedBox(
        width: 96,
        child: Card(
          color: selected ? scheme.tertiaryContainer : null,
          child: InkWell(
            onTap: () => switchValue(value),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: selected ? scheme.tertiary : scheme.secondary,
                    foregroundColor: selected ? scheme.onTertiary : scheme.onSecondary,
                    child: Text(value.number.toString()),
                  ),
                  const SizedBox(height: 4),
                  Text(DateFormat("Hm", S.of(context).localeName).format(value.startTime), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

}