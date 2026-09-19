import 'dart:typed_data';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/card_layout.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

abstract class PlayerCardService {

  static PlayerCard getCardFromPlayer(Player player){
    return PlayerCard(code: player.qrcode);
  }

  static List<PlayerCard> getCardsFromPlayers(List<Player> players){
    return players.map(getCardFromPlayer).toList();
  }

  static PdfColor _color(int argb) => PdfColor.fromInt(argb);

  /// Un contenu posé sur la carte à (x, y) mm, avec son fond optionnel agrandi de [padding] mm.
  static pw.Widget _placed({
    required pw.Widget child,
    required double x,
    required double y,
    required double padding,
    required int? backgroundColor,
  }) {
    return pw.Positioned(
      left: CardLayout.mm(x),
      top: CardLayout.mm(y),
      child: pw.Container(
        padding: pw.EdgeInsets.all(CardLayout.mm(padding)),
        color: backgroundColor != null ? _color(backgroundColor) : null,
        child: child,
      ),
    );
  }

  static pw.Widget _card({
    required int number,
    required String code,
    required pw.ImageProvider backgroundImage,
    required CardLayout layout,
  }) {
    final s = layout.settings;
    final qrSize = CardLayout.mm(s.qrCodeSize);
    return pw.Container(
      height: layout.cardHeight,
      width: layout.cardWidth,
      decoration: pw.BoxDecoration(
        image: pw.DecorationImage(image: backgroundImage, fit: pw.BoxFit.fill),
      ),
      child: pw.Stack(
        children: [
          _placed(
            x: s.qrCodePosX,
            y: s.qrCodePosY,
            padding: s.qrCodePadding,
            backgroundColor: s.qrCodeBackgroundColor,
            child: pw.BarcodeWidget(
              data: code,
              width: qrSize,
              height: qrSize,
              barcode: pw.Barcode.qrCode(errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high),
            ),
          ),
          _placed(
            x: s.idPosX,
            y: s.idPosY,
            padding: s.idPadding,
            backgroundColor: s.idBackgroundColor,
            child: pw.Text(
              number.toString(),
              style: pw.TextStyle(fontSize: s.idFontSize.toDouble(), color: _color(s.idColor)),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Page _page({
    required int page,
    required Event event,
    required pw.ImageProvider backgroundImage,
    required CardLayout layout,
  }) {
    final firstId = layout.firstIdOfPage(page);
    return pw.Page(
      pageFormat: PdfPageFormat(layout.pageWidth, layout.pageHeight),
      margin: pw.EdgeInsets.zero,
      build: (context) => pw.Container(
        color: _color(layout.settings.pageBackgroundColor),
        child: pw.Stack(
          children: List.generate(layout.cardsPerPage, (i) {
            final offset = layout.cardOffset(i);
            return pw.Positioned(
              left: offset.left,
              top: offset.top,
              child: _card(
                number: firstId + i,
                code: event.qrCodeFor(firstId + i),
                backgroundImage: backgroundImage,
                layout: layout,
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Le document complet : les pages de [layout], l'image de fond incorporée une seule fois.
  static Future<Uint8List> generateDocument({
    required Event event,
    required Uint8List backgroundImage,
    required CardLayout layout,
  }) {
    final pdf = pw.Document();
    final image = pw.MemoryImage(backgroundImage);

    for (int page = 0; page < layout.pageCount; page++) {
      pdf.addPage(_page(page: page, event: event, backgroundImage: image, layout: layout));
    }

    return pdf.save();
  }
}
