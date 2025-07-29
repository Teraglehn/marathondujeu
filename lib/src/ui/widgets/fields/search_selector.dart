import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchSelector<OBJ> extends ConsumerStatefulWidget {

  final String? label;
  final TextStyle? labelStyle;
  final Function(OBJ?)? onChanged;
  final Function(OBJ?)? onSaved;
  final bool enabled;
  final bool allowRemove;
  final OBJ? initialValue;
  final String? restorationId;
  final AutovalidateMode? autovalidateMode;
  final String? Function(OBJ?)? validator;

  final Widget Function(
    WidgetRef ref, 
    BuildContext context, 
    FormFieldState<OBJ> state, 
    OBJ value, 
    void Function(OBJ? value) changeValue
  ) suggestionBuilder;

  final Widget Function(
    BuildContext context, 
    FormFieldState<OBJ> state, 
    OBJ? value, 
    void Function(OBJ? value) changeValue
  ) itemBuilder;

  final FutureOr<Iterable<OBJ>> Function(WidgetRef ref, String keyword) getSuggestions;

  final Widget Function(BuildContext, SearchController) Function(FormFieldState<OBJ> state, OBJ? value, Function(SearchController) toggleSearch)? anchorBuilder;

  const SearchSelector({
    required this.getSuggestions,
    required this.itemBuilder,
    required this.suggestionBuilder,
    this.anchorBuilder,
    this.label,
    this.labelStyle,
    this.initialValue,
    this.onChanged,
    this.autovalidateMode,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.allowRemove = false,
    this.restorationId,
    super.key,
  });

  @override
  ConsumerState<SearchSelector<OBJ>> createState() => _SearchSelectorState<OBJ>();
}

class _SearchSelectorState<OBJ> extends ConsumerState<SearchSelector<OBJ>> {
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

  void Function(OBJ?) getChangeValue(SearchController controller, FormFieldState<OBJ> state) {
    return (OBJ? value) {
      widget.onChanged?.call(value);
      state.didChange(value);
      if(controller.isOpen) controller.closeView("");
    };
  }

  toggleSearch(SearchController controller) => controller.isOpen ? controller.closeView("") : controller.openView();

  Widget Function(BuildContext, SearchController) getAnchorBuilder(FormFieldState<OBJ> state){
    if(widget.anchorBuilder != null){
      return widget.anchorBuilder!.call(state, state.value, toggleSearch);
    }
    return (context, controller) => 
      InkWell(
        onTap: !widget.enabled ? null : () => toggleSearch(controller),
        child: InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            labelText: widget.label,
            border: const OutlineInputBorder(),
            errorText: state.hasError ? state.errorText : null,
            suffixIcon: widget.allowRemove && state.value!= null ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: !widget.enabled ? null : () => getChangeValue(controller, state)(null),
            ) : null,
          ),
          child: widget.itemBuilder(context, state, state.value, getChangeValue(controller, state))
        ),
      );
   }

  FutureOr<Iterable<Widget>> Function(BuildContext, SearchController) getSuggestionBuilder(FormFieldState<OBJ> state) {
    return (context, controller) async {
      return (await widget.getSuggestions(ref, controller.text))
        .map((item) => widget.suggestionBuilder(ref, context, state, item, getChangeValue(controller, state)));
    };
  }

  @override
  Widget build(BuildContext context) {
    return FormField<OBJ>(
      validator: widget.validator,
      onSaved: widget.onSaved,
      initialValue: widget.initialValue,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      builder: (state) => SearchAnchor(
        searchController: _controller,
        builder: getAnchorBuilder(state),
        suggestionsBuilder: getSuggestionBuilder(state),
      ),
    );
  }

}