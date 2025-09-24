import 'dart:io';
import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ImageFormField extends FormField<List<byte>> {

  final String? label;
  final TextStyle? labelStyle;
  final bool allowRemove;

  ImageFormField({
    this.label,
    this.labelStyle,
    this.allowRemove = false,
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
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
          lockParentWindow: true
        );
        if (result != null) {
          state.didChange(await File(result.files.first.path!).readAsBytes());
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
        child: state.value != null ? Image.memory(Uint8List.fromList(state.value!)) : Text("select image"),
      ),
    )
  );
}
