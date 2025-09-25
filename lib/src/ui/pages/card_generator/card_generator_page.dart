import 'dart:typed_data';

import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/fields/image_form_field.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class CardGeneratorPage extends ConsumerStatefulWidget {
  const CardGeneratorPage({super.key});

  @override
  ConsumerState<CardGeneratorPage> createState() => _CardGeneratorPageState();
}

class _CardGeneratorPageState extends ConsumerState<CardGeneratorPage> {

  Uint8List? backgroundImage;
  bool generated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 50,
            child: ImageFormField(
              initialValue: null,
              onChanged: (value) {
                if(value != null){
                  setState(() {
                    backgroundImage = Uint8List.fromList(value);
                  });
                }
              },
            )
          ),
          const Divider(),
          Expanded(
            child: Center(
              child: backgroundImage == null ? Text("select image") : PdfPreview(
                  allowSharing: false,
                  canDebug: false,
                  pageFormats: {
                    'A4' : PdfPageFormat.a4.applyMargin(left: 0, top: 0, right: 0, bottom: 0).landscape,
                  },
                  padding: EdgeInsets.zero,
                  build: (format) => PlayerCardService.generateDocument(
                    format: format,
                    startId : 1,
                    endId : 200,
                    backgroundImage : backgroundImage!,
                    qrCodeSize : 116,
                    qrCodePosX : 82,
                    qrCodePosY : 170,
                    idPosX : 10,
                    idPosY : 10,
                    colNb : 4,
                    nbPerCol : 2,
                    cardHeight: PdfPageFormat.a4.landscape.height/2,
                    cardWidth: PdfPageFormat.a4.landscape.width/4,
                  )
                )
            )
          ),
        ],
      )),
    );
  }
}
