import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/models/player_card.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
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
    required PlayerCard card,
    required double qrCodeSize,
    required double padding,
    required double margin,
  }) {

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


  pw.Document generateDocument({required PdfPageFormat format, required List<Player> players}){
    pw.Document pdf = pw.Document();

    int colNb = 1;
    int nbPerCol = 1;
    
    if(identical(format, PdfPageFormat.a4)){

    }

    final cards = PlayerCardService.getCardsFromPlayers(players);

    List<pw.Widget> columns = List.generate(colNb, (i) => pw.Column(
      children: List.generate(nbPerCol, (j) => generateCard(
        card: cards[(i*nbPerCol) + j],
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
    final players = ref.watch(playersProvider(criteria: const SearchCriteria()));
    final main = ref.watch(mainPodProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_cardGenerator_title),
        actions: [
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: main.event,
              onChanged: (event) => mainNotifier.setEvent(event),
            ),
          )
        ],
      ),
      body: EventSelectedGuard(child: Column(
        children: [
          Expanded(
            child: Center(
              child: players.when(
                data:(players) => PdfPreview(
                  allowSharing: false,
                  canDebug: false,
                  pageFormats: const {
                    'A4' : PdfPageFormat.a4,
                    'A3' : PdfPageFormat.a3
                  },
                  padding: EdgeInsets.zero,
                  build: (format) => generateDocument(format: format, players: players).save()
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              )
            )
          ),
        ],
      )),
    );
  }
}
