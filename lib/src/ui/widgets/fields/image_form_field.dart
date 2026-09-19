import 'dart:typed_data';

import 'package:isar_community/isar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImageFormField extends FormField<List<byte>> {

  final String? label;
  final TextStyle? labelStyle;
  final bool allowRemove;
  final FormFieldSetter<List<byte>>? onChanged;

  ImageFormField({
    this.label,
    this.labelStyle,
    this.allowRemove = false,
    required super.initialValue,
    this.onChanged,
    super.autovalidateMode,
    super.onSaved,
    super.validator,
    super.enabled,
    super.restorationId,
    super.key,
  }) : super(
    builder: (state) => InkWell(
      onTap: () async {
        final file = await FilePicker.pickFile(
          type: FileType.image,
          windowsOptions: const WindowsOptions(lockParentWindow: true),
        );
        if (file != null) {
          state.didChange(await file.readAsBytes());
          if(onChanged != null){
            onChanged(state.value);
          }
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
