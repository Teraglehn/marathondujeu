import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'app_icon.dart';

/// Rend l'icône de l'application (L20) : `flutter test tool/render_app_icon_test.dart`.
/// Écrit `assets/icon/app_icon.png` (1024 px) et `windows/runner/resources/app_icon.ico`
/// (16 à 256 px, entrées PNG). Hors de `test/` : la suite ne le joue pas.
void main() {
  testWidgets('rend le PNG et l\'ico', (tester) async {
    await tester.runAsync(() async {
      final png1024 = await render(1024);
      await File('assets/icon/app_icon.png').create(recursive: true);
      await File('assets/icon/app_icon.png').writeAsBytes(png1024);

      const sizes = [16, 24, 32, 48, 64, 128, 256];
      final images = [for (final size in sizes) await render(size)];
      await File('windows/runner/resources/app_icon.ico').writeAsBytes(ico(sizes, images));
    });
  });
}

Future<Uint8List> render(int size) async {
  final recorder = ui.PictureRecorder();
  const AppIconPainter().paint(Canvas(recorder), Size(size.toDouble(), size.toDouble()));
  final image = await recorder.endRecording().toImage(size, size);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return data!.buffer.asUint8List();
}

/// Le format `.ico` : un en-tête, une entrée par image (taille, 32 bits, longueur, position),
/// puis les images — des PNG, que Windows lit depuis Vista.
Uint8List ico(List<int> sizes, List<Uint8List> images) {
  final header = ByteData(6 + 16 * sizes.length);
  header.setUint16(0, 0, Endian.little);
  header.setUint16(2, 1, Endian.little);
  header.setUint16(4, sizes.length, Endian.little);
  var offset = header.lengthInBytes;
  for (var i = 0; i < sizes.length; i++) {
    final entry = 6 + 16 * i;
    header.setUint8(entry, sizes[i] == 256 ? 0 : sizes[i]);
    header.setUint8(entry + 1, sizes[i] == 256 ? 0 : sizes[i]);
    header.setUint8(entry + 2, 0);
    header.setUint8(entry + 3, 0);
    header.setUint16(entry + 4, 1, Endian.little);
    header.setUint16(entry + 6, 32, Endian.little);
    header.setUint32(entry + 8, images[i].length, Endian.little);
    header.setUint32(entry + 12, offset, Endian.little);
    offset += images[i].length;
  }
  return Uint8List.fromList([...header.buffer.asUint8List(), for (final image in images) ...image]);
}
