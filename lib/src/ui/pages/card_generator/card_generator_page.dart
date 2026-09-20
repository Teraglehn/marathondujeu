import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/ui/pages/card_generator/card_sheet_preview.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/color_selector.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/fields/image_form_field.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:marathondujeu/src/ui/widgets/toast.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class CardGeneratorPage extends ConsumerStatefulWidget {
  const CardGeneratorPage({super.key});

  @override
  ConsumerState<CardGeneratorPage> createState() => _CardGeneratorPageState();
}

class _CardGeneratorPageState extends ConsumerState<CardGeneratorPage> {

  // Les réglages en cours d'édition, chargés depuis l'événement sélectionné.
  // `_requestedEventId` évite de relancer le chargement ; `_loadGeneration` avance à chaque
  // chargement terminé : les champs, qui en dépendent par leur clé, se recréent alors.
  int? _requestedEventId;
  int _loadGeneration = 0;
  Event? _event;
  CardSettings _settings = const CardSettings();
  Uint8List? _image;
  double _imageRatio = 1;
  int _start = 1;
  int _end = 1;

  // L'aperçu rapide (Flutter) suit chaque modification ; le PDF, plus lent, ne se rend que sur demande.
  bool _showPdf = false;
  CardLayout? _previewLayout;

  // Les cibles de l'aide de la page (L12).
  final _imageKey = GlobalKey();
  final _sheetKey = GlobalKey();
  final _qrKey = GlobalKey();
  final _numberKey = GlobalKey();
  final _rangeKey = GlobalKey();
  final _previewKey = GlobalKey();
  final _saveKey = GlobalKey();

  List<HelpStep> helpSteps() {
    final s = S.of(context);
    return [
      HelpStep(s.help_cardGenerator_1),
      HelpStep(s.help_cardGenerator_2, target: _imageKey),
      HelpStep(s.help_cardGenerator_3, target: _sheetKey),
      HelpStep(s.help_cardGenerator_4, target: _qrKey),
      HelpStep(s.help_cardGenerator_5, target: _numberKey),
      HelpStep(s.help_cardGenerator_6, target: _rangeKey),
      HelpStep(s.help_cardGenerator_7, target: _previewKey),
      HelpStep(s.help_cardGenerator_8, target: _saveKey),
    ];
  }

  Future<void> _loadFrom(Event event) async {
    final image = event.playerCardBackgroundImage != null ? Uint8List.fromList(event.playerCardBackgroundImage!) : null;
    final ratio = image != null ? await _ratioOf(image) : 1.0;
    await event.players.load();
    if (!mounted) return;
    setState(() {
      _loadGeneration++;
      _event = event;
      _settings = CardSettings.fromEvent(event);
      _image = image;
      _imageRatio = ratio;
      _start = 1;
      _end = event.players.isEmpty ? _settings.cardsPerRow * _settings.rowsPerPage : event.players.length;
      _refreshPreview();
    });
  }

  Future<double> _ratioOf(Uint8List image) async {
    final size = await ImageService.dimensions(image);
    return size.height / size.width;
  }

  void _refreshPreview() {
    _previewLayout = _image == null ? null : CardLayout(settings: _settings, imageRatio: _imageRatio, startId: _start, endId: _end);
  }

  void _update(CardSettings Function(CardSettings) change) {
    setState(() {
      _settings = change(_settings);
      _refreshPreview();
    });
  }

  void _updateRange({int? start, int? end}) {
    setState(() {
      _start = start ?? _start;
      _end = end ?? _end;
      _refreshPreview();
    });
  }

  Future<void> _pickImage(List<int>? bytes) async {
    if (bytes == null) return;
    final image = Uint8List.fromList(bytes);
    final ratio = await _ratioOf(image);
    setState(() {
      _image = image;
      _imageRatio = ratio;
      _refreshPreview();
    });
  }

  Future<void> _save() async {
    final event = _event;
    if (event == null) return;
    _settings.applyTo(event);
    if (_image != null) {
      // Réduite à ce qu'il faut pour imprimer la carte, jamais agrandie.
      _image = await ImageService.shrink(_image!, targetWidth: ImageService.pixelsFor(_settings.cardWidth));
      event.playerCardBackgroundImage = _image;
    }
    await ref.read(eventServiceProvider).save(event);
    if (!mounted) return;
    Toast.show(context, S.of(context).page_cardGenerator_saved);
  }

  /// Crée les joueurs jusqu'au dernier numéro de la plage : leurs cartes sont déjà à l'aperçu.
  Future<void> _generateExtraPlayers() async {
    final event = _event;
    if (event == null) return;
    await ref.read(eventServiceProvider).generateMissingPlayers(event, _end);
  }

  Future<Uint8List> _buildDocument(PdfPageFormat _) {
    return PlayerCardService.generateDocument(event: _event!, backgroundImage: _image!, layout: _previewLayout!);
  }

  // Un champ entier : la clé le réinitialise quand l'événement change.
  Widget _intField(String name, String label, int value, void Function(int) onChanged, {int min = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        key: ValueKey('$name-$_loadGeneration'),
        initialValue: value.toString(),
        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: <TextInputFormatter>[FormattersService.integer],
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), isDense: true),
        onChanged: (text) {
          final parsed = int.tryParse(text);
          if (parsed != null && parsed >= min) onChanged(parsed);
        },
      ),
    );
  }

  // Un champ en mm : décimales acceptées, virgule ou point.
  Widget _mmField(String name, String label, double value, void Function(double) onChanged, {double min = 0}) {
    final text = value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1).replaceAll('.', ',');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        key: ValueKey('$name-$_loadGeneration'),
        initialValue: text,
        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
        inputFormatters: <TextInputFormatter>[FormattersService.unsignedDecimal],
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), isDense: true),
        onChanged: (text) {
          final parsed = double.tryParse(text.replaceAll(',', '.'));
          if (parsed != null && parsed >= min) onChanged(parsed);
        },
      ),
    );
  }

  Widget _colorField(String name, String label, int value, void Function(int) onChanged, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ColorSelector(
        key: ValueKey('$name-$_loadGeneration-$enabled'),
        label: label,
        initialValue: Color(value),
        enabled: enabled,
        onChanged: (color) { if (color != null) onChanged(color.toARGB32()); },
      ),
    );
  }

  /// Fond optionnel : une case « Fond » qui active la couleur.
  Widget _optionalBackground(String name, int? value, void Function(int?) onChanged) {
    return Row(
      children: [
        Checkbox(value: value != null, onChanged: (checked) => onChanged(checked == true ? 0xFFFFFFFF : null)),
        Text(S.of(context).page_cardGenerator_background),
        const SizedBox(width: 8),
        Expanded(child: _colorField(name, S.of(context).page_cardGenerator_backgroundColor, value ?? 0xFFFFFFFF, onChanged, enabled: value != null)),
      ],
    );
  }

  Widget _section(String title, {Key? key}) => Padding(
    key: key,
    padding: const EdgeInsets.only(top: 16, bottom: 4),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );

  Widget _help(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
      ],
    ),
  );

  Widget _settingsPanel(BuildContext context, int playerCount) {
    final s = _settings;
    final t = S.of(context);
    final layout = _previewLayout;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  key: _imageKey,
                  height: 140,
                  child: ImageFormField(
                    key: ValueKey('image-$_loadGeneration'),
                    label: t.page_cardGenerator_image,
                    initialValue: _image,
                    onChanged: _pickImage,
                  ),
                ),

                _section(t.page_cardGenerator_section_sheet, key: _sheetKey),
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(value: false, label: Text(t.page_cardGenerator_portrait), icon: const Icon(Icons.crop_portrait)),
                    ButtonSegment(value: true, label: Text(t.page_cardGenerator_landscape), icon: const Icon(Icons.crop_landscape)),
                  ],
                  selected: {s.landscape},
                  onSelectionChanged: (v) => _update((s) => s.copyWith(landscape: v.first)),
                ),
                _intField('cardsPerRow', t.page_cardGenerator_cardsPerRow, s.cardsPerRow, (v) => _update((s) => s.copyWith(cardsPerRow: v)), min: 1),
                _intField('rowsPerPage', t.page_cardGenerator_rowsPerPage, s.rowsPerPage, (v) => _update((s) => s.copyWith(rowsPerPage: v)), min: 1),
                _mmField('cardWidth', t.page_cardGenerator_cardWidth, s.cardWidth, (v) => _update((s) => s.copyWith(cardWidth: v)), min: 1),
                if (_image != null) _help(t.page_cardGenerator_cardHeight((s.cardWidth * _imageRatio).round())),
                _mmField('pageMargin', t.page_cardGenerator_pageMargin, s.pageMargin, (v) => _update((s) => s.copyWith(pageMargin: v))),
                _mmField('gapX', t.page_cardGenerator_gapX, s.gapX, (v) => _update((s) => s.copyWith(gapX: v))),
                _mmField('gapY', t.page_cardGenerator_gapY, s.gapY, (v) => _update((s) => s.copyWith(gapY: v))),
                _colorField('pageBackground', t.page_cardGenerator_pageBackgroundColor, s.pageBackgroundColor, (v) => _update((s) => s.copyWith(pageBackgroundColor: v))),

                _section(t.page_cardGenerator_section_qrCode, key: _qrKey),
                _help(t.page_cardGenerator_help_positions),
                _mmField('qrSize', t.page_cardGenerator_size, s.qrCodeSize, (v) => _update((s) => s.copyWith(qrCodeSize: v)), min: 1),
                _mmField('qrX', t.page_cardGenerator_posX, s.qrCodePosX, (v) => _update((s) => s.copyWith(qrCodePosX: v))),
                _mmField('qrY', t.page_cardGenerator_posY, s.qrCodePosY, (v) => _update((s) => s.copyWith(qrCodePosY: v))),
                _optionalBackground('qrBackground', s.qrCodeBackgroundColor, (v) => _update((s) => s.copyWith(qrCodeBackgroundColor: v))),
                _mmField('qrPadding', t.page_cardGenerator_padding, s.qrCodePadding, (v) => _update((s) => s.copyWith(qrCodePadding: v))),

                _section(t.page_cardGenerator_section_number, key: _numberKey),
                _mmField('idX', t.page_cardGenerator_posX, s.idPosX, (v) => _update((s) => s.copyWith(idPosX: v))),
                _mmField('idY', t.page_cardGenerator_posY, s.idPosY, (v) => _update((s) => s.copyWith(idPosY: v))),
                _intField('idFontSize', t.page_cardGenerator_fontSize, s.idFontSize, (v) => _update((s) => s.copyWith(idFontSize: v)), min: 1),
                _colorField('idColor', t.page_cardGenerator_color, s.idColor, (v) => _update((s) => s.copyWith(idColor: v))),
                _optionalBackground('idBackground', s.idBackgroundColor, (v) => _update((s) => s.copyWith(idBackgroundColor: v))),
                _mmField('idPadding', t.page_cardGenerator_padding, s.idPadding, (v) => _update((s) => s.copyWith(idPadding: v))),

                _section(t.page_cardGenerator_section_range),
                Row(
                  key: _rangeKey,
                  children: [
                    Expanded(child: _intField('start', t.page_cardGenerator_from, _start, (v) => _updateRange(start: v), min: 1)),
                    const SizedBox(width: 8),
                    Expanded(child: _intField('end', t.page_cardGenerator_to, _end, (v) => _updateRange(end: v), min: 1)),
                  ],
                ),
                // Des cartes au-delà des joueurs existants : proposer de créer ces joueurs.
                Row(
                  children: [
                    Expanded(child: _help(t.page_cardGenerator_playerCount(playerCount))),
                    if (_end > playerCount) TextButton.icon(
                      onPressed: _generateExtraPlayers,
                      icon: const Icon(Icons.person_add),
                      label: Text(t.page_cardGenerator_generateExtraPlayers),
                    ),
                  ],
                ),
                if (layout != null) _help(t.page_cardGenerator_summary(layout.cardCount, layout.startId, layout.endId, layout.pageCount)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                key: _saveKey,
                onPressed: _save,
                style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                child: Text(t.utils_button_save),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _previewPane(BuildContext context) {
    final t = S.of(context);
    final layout = _previewLayout;
    if (layout == null || _event == null) {
      return Center(child: Text(t.page_cardGenerator_noImage));
    }
    return Column(
      children: [
        Padding(
          key: _previewKey,
          padding: const EdgeInsets.all(8.0),
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: false, label: Text(t.page_cardGenerator_quickPreview), icon: const Icon(Icons.bolt)),
              ButtonSegment(value: true, label: Text(t.page_cardGenerator_pdfPreview), icon: const Icon(Icons.picture_as_pdf)),
            ],
            selected: {_showPdf},
            onSelectionChanged: (v) => setState(() => _showPdf = v.first),
          ),
        ),
        if (!_showPdf) _help(t.page_cardGenerator_quickPreview_help),
        Expanded(
          child: _showPdf
            ? PdfPreview(
                key: ValueKey((layout.settings, layout.startId, layout.endId, _image.hashCode)),
                build: _buildDocument,
                allowSharing: false,
                canDebug: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                padding: EdgeInsets.zero,
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: CardSheetPreview(event: _event!, image: _image!, layout: layout),
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_cardGenerator_title),
        actions: [
          const ScanStatus(),
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: selectedEvent.value,
              onChanged: (event) => mainNotifier.setEventId(event?.id),
            ),
          ),
          HelpButton(steps: helpSteps),
        ],
      ),
      body: EventSelectedGuard(builder: (event) {
        if (event.id != _requestedEventId) {
          _requestedEventId = event.id;
          _loadFrom(event);
        }
        final playerCount = ref.watch(playersProvider(eventId: event.id)).value?.length ?? 0;
        return PlayerSessionScanner(child: Row(
          children: [
            SizedBox(width: 420, child: _settingsPanel(context, playerCount)),
            const VerticalDivider(width: 1),
            Expanded(child: _previewPane(context)),
          ],
        ));
      }),
    );
  }
}
