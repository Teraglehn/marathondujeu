import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// Aperçu rapide d'une planche : la première page, dessinée par Flutter à l'échelle,
/// sans passer par le PDF. Une unité = un point PDF, la page est ajustée à l'espace disponible.
class CardSheetPreview extends StatelessWidget {
  final Event event;
  final Uint8List image;
  final CardLayout layout;

  const CardSheetPreview({super.key, required this.event, required this.image, required this.layout});

  Widget _placed({required Widget child, required double x, required double y, required double padding, required int? backgroundColor}) {
    return Positioned(
      left: CardLayout.mm(x),
      top: CardLayout.mm(y),
      child: Container(
        padding: EdgeInsets.all(CardLayout.mm(padding)),
        color: backgroundColor != null ? Color(backgroundColor) : null,
        child: child,
      ),
    );
  }

  Widget _card(int number) {
    final s = layout.settings;
    final qrSize = CardLayout.mm(s.qrCodeSize);
    return SizedBox(
      width: layout.cardWidth,
      height: layout.cardHeight,
      child: Stack(
        children: [
          Positioned.fill(child: Image.memory(image, fit: BoxFit.fill, gaplessPlayback: true)),
          _placed(
            x: s.qrCodePosX, y: s.qrCodePosY, padding: s.qrCodePadding, backgroundColor: s.qrCodeBackgroundColor,
            child: SizedBox(
              width: qrSize,
              height: qrSize,
              child: PrettyQrView(
                qrImage: PlayerCard(code: event.qrCodeFor(number)).getQrImage(),
                decoration: const PrettyQrDecoration(shape: PrettyQrSmoothSymbol(roundFactor: 0)),
              ),
            ),
          ),
          _placed(
            x: s.idPosX, y: s.idPosY, padding: s.idPadding, backgroundColor: s.idBackgroundColor,
            child: Text(
              number.toString(),
              style: TextStyle(fontSize: s.idFontSize.toDouble(), color: Color(s.idColor), height: 1),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstId = layout.firstIdOfPage(0);
    return FittedBox(
      child: Material(
        elevation: 4,
        child: Container(
          width: layout.pageWidth,
          height: layout.pageHeight,
          color: Color(layout.settings.pageBackgroundColor),
          child: Stack(
            children: List.generate(layout.cardsPerPage, (i) {
              final offset = layout.cardOffset(i);
              return Positioned(left: offset.left, top: offset.top, child: _card(firstId + i));
            }),
          ),
        ),
      ),
    );
  }
}
