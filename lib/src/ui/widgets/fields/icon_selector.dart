import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/services/icon.service.dart';
import 'package:flutter/material.dart';

class IconCategoryItem {
  final IconCategory category;
  final String Function(BuildContext) getName;

  IconCategoryItem(this.category, this.getName);
}

class IconSelector extends StatefulWidget {

  final String? label;
  final TextStyle? labelStyle;
  final Function(IconData?)? onChanged;
  final Function(IconData?)? onSaved;
  final bool enabled;
  final IconData? initialValue;
  final String? restorationId;
  final AutovalidateMode? autovalidateMode;
  final String? Function(IconData?)? validator;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const IconSelector({
    this.label,
    this.labelStyle,
    this.initialValue,
    this.onChanged,
    this.autovalidateMode,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.restorationId,
    this.iconBackgroundColor,
    this.iconColor,
    super.key,
  });

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {

  final SearchController controller = SearchController();

  // final iconCategories = [
    // IconCategoryItem(IconCategory.rounded, (context) => S.of(context).utils_icon_rounded),
    // IconCategoryItem(IconCategory.filled, (context) => S.of(context).utils_icon_filled),
    // IconCategoryItem(IconCategory.outlined, (context) => S.of(context).utils_icon_outlined),
    // IconCategoryItem(IconCategory.sharp, (context) => S.of(context).utils_icon_sharp),
  // ];

  // late IconCategoryItem iconCategoryItem;

  @override
  void initState() {
    super.initState();
    //iconCategoryItem = iconCategories.first;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget itemBuilder(IconData icon) => CircleAvatar(
    backgroundColor: widget.iconBackgroundColor,
    child: Icon(icon, color: widget.iconColor),
  );

  @override
  Widget build(BuildContext context) {
    return FormField<IconData>(
      validator: widget.validator,
      onSaved: widget.onSaved,
      initialValue: widget.initialValue,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      builder: (state) => SearchAnchor(
        searchController: controller,
        builder: (context, controller) => InkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.closeView("");
            } else {
              controller.openView();
            }
          },
          mouseCursor: SystemMouseCursors.click,
          child: InputDecorator(
            decoration: InputDecoration(
                isDense: true,
                labelText: widget.label,
                border: const OutlineInputBorder(),
                errorText: state.hasError ? state.errorText : null,
              ),
            child: ListTile(
              leading: state.value != null ? itemBuilder(state.value!) : null,
              title: Text(S.of(context).widget_iconSelector_selectTitle),
            )
          )
        ),
        viewBuilder: (suggestions) {
          return GridView.extent(
            padding: const EdgeInsets.all(10),
            maxCrossAxisExtent: 40,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            semanticChildCount: suggestions.length,
            children: suggestions.toList()
          );
        },
        suggestionsBuilder: (context, controller) {
          return IconService.searchIconsByCategory(controller.text, IconCategory.rounded).map((icon) => 
            InkWell(
              onTap: () {
                state.didChange(icon);
                widget.onChanged?.call(icon);
                controller.closeView("");
              },
              child: itemBuilder(icon),
            )
          );
        },
      ),
    );
  }
}