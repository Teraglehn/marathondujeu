import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiSearchSelector<OBJ> extends ConsumerStatefulWidget {

  final String? label;
  final TextStyle? labelStyle;
  final Function(Set<OBJ>)? onChanged;
  final Function(Set<OBJ>?)? onSaved;
  final bool enabled;
  /// Lecture seule : le sélecteur s'ouvre et montre les choix, mais rien ne se coche ni se décoche.
  final bool readOnly;
  final bool allowRemove;
  final Set<OBJ>? initialValue;
  final String? restorationId;
  final AutovalidateMode? autovalidateMode;
  final String? Function(Set<OBJ>?)? validator;

  final Widget Function(
    WidgetRef ref, 
    BuildContext context, 
    FormFieldState<Set<OBJ>> state, 
    OBJ value, 
    void Function(Set<OBJ> value) changeValue, 
    void Function(OBJ value) switchValue
  ) suggestionBuilder;

  final Widget Function(
    BuildContext context, 
    FormFieldState<Set<OBJ>> state, 
    Set<OBJ> value, 
    void Function(Set<OBJ> value) changeValue, 
    void Function(OBJ value) switchValue
  ) itemBuilder;

  final FutureOr<Iterable<OBJ>> Function(WidgetRef ref, String keyword) getSuggestions;

  /// Disposition des suggestions ; par défaut, la liste de `SearchAnchor`.
  final Widget Function(Iterable<Widget> suggestions)? viewBuilder;

  final Widget Function(BuildContext, SearchController) Function(FormFieldState<Set<OBJ>> state, Set<OBJ>? value, Function(SearchController) toggleSearch)? anchorBuilder;

  const MultiSearchSelector({
    required this.getSuggestions,
    required this.itemBuilder,
    required this.suggestionBuilder,
    this.anchorBuilder,
    this.viewBuilder,
    this.label,
    this.labelStyle,
    this.initialValue,
    this.onChanged,
    this.autovalidateMode,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.allowRemove = false,
    this.restorationId,
    super.key,
  });

  @override
  ConsumerState<MultiSearchSelector<OBJ>> createState() => _MultiSearchSelectorState<OBJ>();
}

class _MultiSearchSelectorState<OBJ> extends ConsumerState<MultiSearchSelector<OBJ>> {
  late final SearchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose(); //TODO find a solution to fast close
  }

  void Function(Set<OBJ>) getChangeValue(SearchController controller, FormFieldState<Set<OBJ>> state) {
    if (widget.readOnly) return (_) {};
    return (Set<OBJ> value) {
      widget.onChanged?.call(value);
      state.didChange(value);
      if(controller.isOpen) controller.closeView("");
    };
  }

  void Function(OBJ) getSwitchValue(SearchController controller, FormFieldState<Set<OBJ>> state) {
    if (widget.readOnly) return (_) {};
    return (OBJ value) {
      Set<OBJ> set = state.value ?? {};
      if(set.contains(value)) {
        set.remove(value);
      } else {
        set.add(value);
      }
      widget.onChanged?.call(set);
      state.didChange(set);
      final query = controller.text;
      controller.text = "$query ";
      controller.text = query;
    };
  }

  void toggleSearch(SearchController controller) => controller.isOpen ? controller.closeView("") : controller.openView();

  Widget Function(BuildContext, SearchController) getAnchorBuilder(FormFieldState<Set<OBJ>> state){
    if(widget.anchorBuilder != null){
      return widget.anchorBuilder!.call(state, state.value, toggleSearch);
    }
    // Désactivé : aucun clic ne passe, et le champ se grise comme les autres.
    return (context, controller) => IgnorePointer(
      ignoring: !widget.enabled,
      child: InkWell(
        onTap: !widget.enabled ? null : () => toggleSearch(controller),
        child: InputDecorator(
          decoration: InputDecoration(
            enabled: widget.enabled,
            isDense: true,
            labelText: widget.label,
            border: const OutlineInputBorder(),
            errorText: state.hasError ? state.errorText : null,
            suffixIcon: widget.allowRemove && state.value!= null ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: !widget.enabled ? null : () => getChangeValue(controller, state)({}),
            ) : null,
          ),
          child: widget.itemBuilder(context, state, state.value ?? {}, getChangeValue(controller, state), getSwitchValue(controller, state))
        ),
      ),
    );
  }

  FutureOr<Iterable<Widget>> Function(BuildContext, SearchController) getSuggestionBuilder(FormFieldState<Set<OBJ>> state) {
    return (context, controller) async {
      return (await widget.getSuggestions(ref, controller.text))
        .map((item) => widget.suggestionBuilder(ref, context, state, item, getChangeValue(controller, state), getSwitchValue(controller, state)));
    };
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Set<OBJ>>(
      validator: widget.validator,
      onSaved: widget.onSaved,
      initialValue: widget.initialValue,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      builder: (state) => SearchAnchor(
        searchController: _controller,
        builder: getAnchorBuilder(state),
        suggestionsBuilder: getSuggestionBuilder(state),
        viewBuilder: widget.viewBuilder,
      ),
    );
  }

}