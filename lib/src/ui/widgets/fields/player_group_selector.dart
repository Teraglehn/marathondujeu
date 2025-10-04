import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/player_groups.dart';
import 'package:marathondujeu/src/ui/widgets/fields/multi_search_selector.dart';
import 'package:flutter/material.dart';

class PlayerGroupSelector extends MultiSearchSelector<PlayerGroup> {

  PlayerGroupSelector({
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
    required Event event,
    List<PlayerGroup>? groups,
  }) : super(
    getSuggestions: (ref, keyword) async {
      List<PlayerGroup> filteredGroups = groups ?? await ref.watch(playerGroupsProvider(eventId : event.id).future);
      return filteredGroups
        .where((element) => element.name.toLowerCase().contains(keyword.toLowerCase()))
        .take(15)
        .toList();
    },
    itemBuilder: (context, state, value, changeValue, switchValue) => 
      ListTile(
        title: value.isEmpty ? Text(S.of(context).widget_playerGroupSelector_selectTitle) : Text(value.map((v) => v.name).join(", ")), 
        contentPadding: const EdgeInsets.all(0),
      ),
    suggestionBuilder: (ref, context, state, value, changeValue, switchValue) => 
      ListTile( 
        leading: Checkbox(
          value: state.value?.contains(value) ?? false, 
          onChanged: (_) => switchValue(value)
        ),
        title: Text(value.name),
        selected: state.value?.contains(value) ?? false,
        selectedColor: Theme.of(context).colorScheme.onTertiaryContainer,
        selectedTileColor: Theme.of(context).colorScheme.tertiaryContainer,
        onTap: () {
          switchValue(value);
        }
      ),
  );

}