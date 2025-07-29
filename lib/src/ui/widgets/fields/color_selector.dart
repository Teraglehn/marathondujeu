import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {

  final String? label;
  final TextStyle? labelStyle;
  final Function(Color?)? onChanged;
  final Function(Color?)? onSaved;
  final bool enabled;
  final Color? initialValue;
  final String? restorationId;
  final AutovalidateMode? autovalidateMode;
  final String? Function(Color?)? validator;

  const ColorSelector({
    this.label,
    this.labelStyle,
    this.initialValue,
    this.onChanged,
    this.autovalidateMode,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.restorationId,
    super.key,
  });

  
  Future<bool> showColorPickerDialog(BuildContext context, Color color, Function(Color) onColorChanged) async {
    return ColorPicker(
      color: color,
      onColorChanged: onColorChanged,
      showColorCode: true,
      title: Text(S.of(context).widget_colorSelector_selectTitle),
      enableOpacity: false,
      enableShadesSelection: false,
      enableTonalPalette: false,
      enableTooltips: false,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.primary: false,
      },
    ).showPickerDialog(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Color>(
      validator: validator,
      onSaved: onSaved,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      restorationId: restorationId,
      builder: (state) {
        return InkWell(
          mouseCursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onTap: enabled ? () async {
            Color? colorAfter;

            final result = await showColorPickerDialog(context, state.value ?? Colors.transparent, (color) {
              colorAfter = color;
            });
            if(result && colorAfter != null) {
              state.didChange(colorAfter);
              onChanged?.call(colorAfter);
            }
          } : null,
          child: InputDecorator(
            decoration: InputDecoration(
              isDense: true,
              labelText: label,
              border: const OutlineInputBorder(),
              errorText: state.hasError ? state.errorText : null,
            ),
            child: ListTile(
              leading : ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: state.value ?? Colors.transparent,
              ),
              title: Text(S.of(context).widget_colorSelector_selectTitle), 
              contentPadding: const EdgeInsets.all(0),
            )
              
          ),
        );
      },
    );
  }

}