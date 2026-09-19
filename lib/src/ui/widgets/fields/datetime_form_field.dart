import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends FormField<DateTime> {

  final String? label;
  final TextStyle? labelStyle;
  final String dateFormat;
  final String hourFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool allowRemove;

  DateTimeFormField({
    this.label,
    this.labelStyle,
    this.dateFormat = 'yMd',
    this.hourFormat = 'Hm',
    this.allowRemove = false,
    this.firstDate,
    this.lastDate,
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
        final firstDateActual = firstDate ?? DateTime(2000);
        final lastDateActual = lastDate ?? DateTime(2100);
        var initialDate = state.value ?? DateTime.now();
        if(initialDate.isBefore(firstDateActual)){
          initialDate = firstDateActual;
        } else if (initialDate.isAfter(lastDateActual)){
          initialDate = lastDateActual;
        }

        var date = await showDatePicker(
          context: state.context,
          initialDate: initialDate,
          firstDate: firstDateActual,
          lastDate: lastDateActual,
        );
        if (date == null || !state.mounted) return;
        final time = await showTimePicker(
          context: state.context, 
          initialTime: state.value != null ? TimeOfDay.fromDateTime(state.value!) : TimeOfDay.now(),
        );
        if(time != null){
          date = date.copyWith(hour: time.hour, minute: time.minute);
        }
        state.didChange(date);
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
        child: Text(state.value == null ? '' : "${DateFormat(dateFormat, S.of(state.context).localeName).format(state.value!)} - ${DateFormat(hourFormat, S.of(state.context).localeName).format(state.value!)}"),
      ),
    )
  );
}
