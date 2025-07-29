import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeFormField extends FormField<DateTimeRange> {

  final String? label;
  final TextStyle? labelStyle;
  final String dateFormat;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool allowRemove;

  DateRangeFormField({
    this.label,
    this.labelStyle,
    this.dateFormat = 'yMd',
    this.allowRemove = false,
    required this.firstDate,
    required this.lastDate,
    required super.initialValue,
    super.autovalidateMode,
    super.onSaved,
    super.validator,
    super.enabled,
    super.restorationId,
    super.key,
  }) : super(
    builder: (state) => InkWell(
      onTap: () async {
        final dateRange = await showDateRangePicker(
          context: state.context,
          initialDateRange: state.value,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (dateRange != null) {
          state.didChange(dateRange);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.calendar_today),
          errorText: state.hasError ? state.errorText : null,
          suffixIcon: allowRemove ? IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.clear),
            onPressed: () {
              state.didChange(null);
            },
          ) : null,
        ),
        child: Text(state.value == null ? '' : "${DateFormat(dateFormat, S.of(state.context).localeName).format(state.value!.start)} - ${DateFormat(dateFormat, S.of(state.context).localeName).format(state.value!.end)}"),
      ),
    )
  );
}
