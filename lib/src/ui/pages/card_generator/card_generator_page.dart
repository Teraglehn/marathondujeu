import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/models/player_card.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CardGeneratorPage extends ConsumerStatefulWidget {
  const CardGeneratorPage({super.key});

  @override
  ConsumerState<CardGeneratorPage> createState() => _CardGeneratorPageState();
}

class _CardGeneratorPageState extends ConsumerState<CardGeneratorPage> {

  @override
  void initState() {
    super.initState();
  }

  pw.Widget generateCard({
    required double qrCodeSize,
    required double padding,
    required double margin,
  }) {
    PlayerCard card = PlayerCardService.generatePlayerCard();

    double height = qrCodeSize + (2*padding) + (2*margin);
    double width = qrCodeSize + (2*padding) + (2*margin) + 180;

    return pw.SizedBox(
      height: height,
      width: width,
      child: pw.Container(
        margin: pw.EdgeInsets.all(margin),
        padding: pw.EdgeInsets.all(padding),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black)
        ),
        child: pw.Row(
          children: [
            pw.SizedBox(
              width: qrCodeSize,
              height: qrCodeSize,
              child: pw.BarcodeWidget(
                data: card.code,
                width: qrCodeSize,
                height: qrCodeSize,
                barcode: pw.Barcode.qrCode(errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high)
              ) 
            ),
            pw.Expanded(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8.0),
                child : pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Prénom :'),
                    pw.Text('NOM :'),
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }


  pw.Document generatePage(PdfPageFormat format){
    int nbPerCol = 20;
    int colNb = 4;
    pw.Document pdf = pw.Document();

    List<pw.Widget> columns = List.generate(colNb, (_) => pw.Column(
      children: List.generate(nbPerCol, (_) => generateCard(
        qrCodeSize: 60,
        margin: 2,
        padding: 5
      ))
    ));

    pdf.addPage(pw.Page(
      pageFormat: format,
      build: (context) => pw.Row(
        children: columns
      )
    ));

    return pdf;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_cardGenerator_title),
      ),
      body: Column(
        children: [
          Row(
            children: [],
          ),
          Expanded(
            child: Center(
              child: PdfPreview(
                allowSharing: false,
                canDebug: false,
                pageFormats: const {
                  'A4' : PdfPageFormat.a4,
                  'A3' : PdfPageFormat.a3
                },
                padding: EdgeInsets.zero,
                build: (format) => generatePage(format).save()
              )
            )
          ),
        ],
      ),
    );
  }
}
