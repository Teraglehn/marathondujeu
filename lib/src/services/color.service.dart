import 'dart:math';
import 'dart:ui';

class ColorService {
  static Color getContrastColor(Color bgColor, Color lightColor, Color darkColor) {
  var r = (bgColor.r * 255).round() & 0xff;
  var g = (bgColor.g * 255).round() & 0xff;
  var b = (bgColor.b * 255).round() & 0xff;
  var uicolors = [r / 255, g / 255, b / 255];
  var c = uicolors.map((col) {
    if (col <= 0.03928) {
      return col / 12.92;
    }
    return pow((col + 0.055) / 1.055, 2.4);
  });
  var L = (0.2126 * c.elementAt(0)) + (0.7152 * c.elementAt(1)) + (0.0722 * c.elementAt(2));
  return (L > 0.179) ? darkColor : lightColor;
}
}