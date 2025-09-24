import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/ui/widgets/fields/search_selector.dart';
import 'package:flutter/material.dart';

class EventSelector extends SearchSelector<Event> {

  EventSelector({
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
    super.restorationId,
    super.key,
    List<Event>? events,
  }) : super(
    getSuggestions: (ref, keyword) async {
      List<Event> filteredEvents = events ?? await ref.watch(eventsProvider().future);
      return filteredEvents
        .where((element) => element.name.toLowerCase().contains(keyword.toLowerCase()))
        .take(15)
        .toList();
    },
    itemBuilder: (context, state, value, changeValue) => 
      ListTile(
        title: value == null ? Text(S.of(context).widget_eventSelector_selectTitle) : Text(value.name), 
        contentPadding: const EdgeInsets.all(0),
      ),
    suggestionBuilder: (ref, context, state, value, changeValue) => 
      ListTile( 
        title: Text(value.name),
        selected: state.value == value,
        selectedColor: Theme.of(context).colorScheme.onTertiaryContainer,
        selectedTileColor: Theme.of(context).colorScheme.tertiaryContainer,
        onTap: () {
          changeValue(value);
        }
      ),
  );

}