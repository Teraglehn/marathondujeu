import 'dart:math';
import 'dart:typed_data';
import 'package:marathondujeu/src/data/data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

abstract class PlayerCardService {

  static PlayerCard getCardFromPlayer(Player player){
    return PlayerCard(code: player.qrcode);
  }

  static List<PlayerCard> getCardsFromPlayers(List<Player> players){
    return players.map(getCardFromPlayer).toList();
  }

  static pw.Widget _generateCard({
    required String id,
    required Uint8List backgroundImage,
    required double qrCodeSize,
    required int qrCodePosX,
    required int qrCodePosY,
    required int idPosX,
    required int idPosY,
    required double cardHeight,
    required double cardWidth,
  }) {
    return pw.Container(
      height: cardHeight,
      width: cardWidth,
      decoration: pw.BoxDecoration(
         image: pw.DecorationImage(
           image: pw.MemoryImage(backgroundImage),
           fit: pw.BoxFit.fitHeight,
         )
       ),
      child: pw.Stack(
        children: [
          pw.Container(
            height: qrCodeSize,
            width: qrCodeSize,
            margin: pw.EdgeInsets.only(
              left : qrCodePosX.toDouble(), 
              top: qrCodePosY.toDouble()
            ),
            child: pw.SizedBox(
              width: qrCodeSize,
              height: qrCodeSize,
              child: pw.BarcodeWidget(
                data: id,
                width: qrCodeSize,
                height: qrCodeSize,
                barcode: pw.Barcode.qrCode(errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high)
              ) 
            ),
          ),
          pw.Container(
            margin: pw.EdgeInsets.only(
              left : idPosX.toDouble(), 
              top: idPosY.toDouble()
            ),
            child: pw.Text(id)
          ),
        ]
      )
    );
  }

  static pw.Page generatePage({
    required PdfPageFormat format,
    required int startId,
    required int endId,
    required Uint8List backgroundImage,
    required double qrCodeSize,
    required int qrCodePosX,
    required int qrCodePosY,
    required int idPosX,
    required int idPosY,
    required int colNb,
    required int nbPerCol,
    required double cardHeight,
    required double cardWidth,
  }) {
    List<pw.Widget> columns = List.generate(colNb, (i) => pw.Column(
      children: List.generate(nbPerCol, (j) => _generateCard(
        id : (startId + i*nbPerCol + j).toString(),
        backgroundImage : backgroundImage,
        qrCodeSize : qrCodeSize,
        qrCodePosX : qrCodePosX,
        qrCodePosY : qrCodePosY,
        idPosX : idPosX,
        idPosY : idPosY,
        cardHeight: cardHeight,
        cardWidth: cardWidth,
      ))
    ));

    return pw.Page(
      pageFormat: format,
      orientation: pw.PageOrientation.landscape,
      margin: const pw.EdgeInsets.all(0),
      build: (context) => pw.Expanded(child: pw.Row(
        children: columns
      ))
    );
  }

  static Future<Uint8List> generateDocument({
    required PdfPageFormat format,
    required int startId,
    required int endId,
    required Uint8List backgroundImage,
    required double qrCodeSize,
    required int qrCodePosX,
    required int qrCodePosY,
    required int idPosX,
    required int idPosY,
    required int colNb,
    required int nbPerCol,
    required double cardHeight,
    required double cardWidth,
  }) {
    pw.Document pdf = pw.Document();

    int countPerPage = colNb*nbPerCol;
    int nbCards = endId - startId+1;
    int nbPage = (nbCards / countPerPage).ceil();

    for(int i = 0; i<nbPage; i++){
      int pageStart = startId + i*countPerPage;
      pdf.addPage(generatePage(
        format : format,
        startId : startId + i*countPerPage,
        endId : min(endId, pageStart+countPerPage),
        backgroundImage : backgroundImage,
        qrCodeSize : qrCodeSize,
        qrCodePosX : qrCodePosX,
        qrCodePosY : qrCodePosY,
        idPosX : idPosX,
        idPosY : idPosY,
        colNb : colNb,
        nbPerCol : nbPerCol,
        cardHeight: cardHeight,
        cardWidth: cardWidth,
      ));
    }

    return pdf.save();
  }

}