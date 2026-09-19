import 'dart:typed_data';
import 'dart:ui' as ui;

/// Lecture et réduction d'une image de fond de carte, avec le décodeur de Flutter — sans dépendance.
abstract class ImageService {
  static const int printDpi = 300;

  /// Largeur et hauteur en pixels.
  static Future<({int width, int height})> dimensions(Uint8List bytes) async {
    final descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(bytes));
    final size = (width: descriptor.width, height: descriptor.height);
    descriptor.dispose();
    return size;
  }

  /// Le nombre de pixels qu'il faut pour imprimer [widthMm] à [printDpi].
  static int pixelsFor(double widthMm) => (widthMm / 25.4 * printDpi).round();

  /// Réduit l'image à [targetWidth] pixels de large (PNG), sans jamais l'agrandir.
  static Future<Uint8List> shrink(Uint8List bytes, {required int targetWidth}) async {
    final size = await dimensions(bytes);
    if (size.width <= targetWidth) return bytes;

    final codec = await ui.instantiateImageCodec(bytes, targetWidth: targetWidth);
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    frame.image.dispose();
    codec.dispose();
    return data!.buffer.asUint8List();
  }
}
