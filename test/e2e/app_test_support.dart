import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/marathon_app.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/ui/widgets/fields/datetime_form_field.dart';
import 'package:marathondujeu/src/ui/widgets/toast.dart';

import '../isar_test_support.dart';

/// Le harnais du parcours (L18) : l'application entière, montée sur une base Isar temporaire,
/// et les gestes d'un organisateur — clics, frappes, scans — avec ce qu'il faut pour attendre
/// la base.
///
/// La base répond par le vrai event loop, hors de l'horloge factice du test : chaque attente
/// passe par `tester.runAsync` un instant, puis par un `pump`. C'est le sens de [tick].
class App {
  final WidgetTester tester;
  final Isar isar;

  /// Les dialogues de fichier du système, remplacés par des chemins que le test pose (L09).
  final FakeBackupFilePicker picker = FakeBackupFilePicker();

  /// Les textes de l'application, en français : ce que l'organisateur lit.
  final S s = lookupS(const Locale('fr'));

  /// L'étape et le geste en cours, pour nommer un échec.
  String step = '';
  String gesture = '';

  App._(this.tester, this.isar);

  /// Monte `MarathonApp` sur [isar], en français, dans une fenêtre de bureau. Ferme [isar] à la fin.
  static Future<App> launch(WidgetTester tester, Isar isar) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.localesTestValue = [const Locale('fr')];
    addTearDown(() async {
      // Démonter l'application avant de fermer la base : ses flux Isar tiennent la fermeture,
      // et ce qu'elle a lancé doit finir hors horloge factice. La fermeture se fait ici, hors
      // horloge aussi — dans un `tearDownAll` elle ne rend jamais la main après un échec.
      await tester.pumpWidget(const SizedBox.shrink());
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pump();
      }
      await tester.runAsync(() => isar.close(deleteFromDisk: true).timeout(const Duration(seconds: 10), onTimeout: () => false));
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.platformDispatcher.clearLocalesTestValue();
    });
    // La police de test est plus haute et plus large que Roboto : des blocs qui tiennent sur le
    // poste débordent ici. Les débordements ne comptent pas (C11).
    final onError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('overflowed by')) return;
      onError?.call(details);
    };
    addTearDown(() => FlutterError.onError = onError);
    final app = App._(tester, isar);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        isarClientProvider.overrideWithValue(TestIsarClient(isar)),
        backupFilePickerProvider.overrideWithValue(app.picker),
      ],
      child: const EagerInitialization(child: MarathonApp()),
    ));
    await app.settle();
    return app;
  }

  // ---------------------------------------------------------------- étapes

  /// Une étape du parcours : un échec dedans est renommé avec l'étape et le geste en cours.
  Future<void> run(String name, Future<void> Function() body) async {
    step = name;
    gesture = '';
    try {
      await body();
    } catch (e, st) {
      // ignore: avoid_print
      print('À l\'écran : ${screen()}');
      Error.throwWithStackTrace(TestFailure('Étape $step — geste $gesture : $e'), st);
    }
  }

  /// À la fin du parcours : laisse expirer les minuteurs (toasts) — un minuteur en attente
  /// fait échouer le test.
  Future<void> finish() async {
    await tester.pump(const Duration(seconds: 5));
    await tick();
  }

  /// Le geste que les constats qui suivent vérifient.
  void g(String id) => gesture = id;

  // ---------------------------------------------------------------- attente

  /// Laisse la base répondre, puis rend les frames en attente. Une animation sans fin (un
  /// indicateur d'attente) ne bloque pas : au bout de deux secondes d'horloge, on passe.
  Future<void> tick() async {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 5)));
    try {
      await tester.pumpAndSettle(const Duration(milliseconds: 100), EnginePhase.sendSemanticsUpdate, const Duration(seconds: 2));
    } on FlutterError catch (e) {
      if (!e.message.contains('pumpAndSettle timed out')) rethrow;
    }
  }

  Future<void> settle() async {
    for (var i = 0; i < 4; i++) {
      await tick();
    }
  }

  /// Laisse passer [duration] d'horloge (toasts, minuteurs).
  Future<void> wait(Duration duration) async {
    await tester.pump(duration);
    await tick();
  }

  /// Attend que [finder] trouve quelque chose — trois secondes réelles au plus.
  Future<Finder> waitFor(Finder finder, {String? what}) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!found(finder)) {
      if (DateTime.now().isAfter(deadline)) {
        fail('${what ?? finder.describeMatch(Plurality.one)} : introuvable');
      }
      await tick();
    }
    return finder;
  }

  /// Attend que [finder] ne trouve plus rien.
  Future<void> waitGone(Finder finder, {String? what}) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (found(finder)) {
      if (DateTime.now().isAfter(deadline)) {
        fail('${what ?? finder.describeMatch(Plurality.one)} : toujours là');
      }
      await tick();
    }
  }

  /// Vrai si [finder] trouve quelque chose (`.first` lève sur rien : c'est « rien »).
  static bool found(Finder finder) {
    try {
      return finder.evaluate().isNotEmpty;
    } on StateError {
      return false;
    }
  }

  /// Attend que la base dise vrai — [check] lit la base, hors horloge factice. L'application
  /// finit d'écrire d'abord ([settle]) : lire pendant qu'elle écrit rend l'ancien état. Et
  /// l'écran suit la base après coup : un dernier [settle] avant de rendre la main.
  Future<void> until(Future<bool> Function() check, {required String what}) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (true) {
      await settle();
      if (await tester.runAsync(check) == true) break;
      if (DateTime.now().isAfter(deadline)) fail('$what : toujours faux en base');
    }
    await settle();
  }

  /// Le texte est à l'écran.
  Future<void> see(String text) => waitFor(find.text(text, findRichText: true), what: '« $text »');

  /// Le texte n'est pas à l'écran (après avoir laissé la base répondre).
  Future<void> dontSee(String text) async {
    await settle();
    expect(find.text(text, findRichText: true), findsNothing, reason: '« $text » ne devrait pas être là');
  }

  // ---------------------------------------------------------------- gestes

  /// Un clic — après avoir fait défiler jusqu'à la cible si elle est dans une liste.
  Future<void> tap(Finder finder, {String? what}) async {
    await waitFor(finder, what: what);
    await tester.ensureVisible(finder.first);
    await tester.tap(finder.first);
    await tick();
  }

  /// Un clic sur un texte : un bouton, une ligne, un onglet.
  Future<void> tapText(String text) => tap(find.text(text), what: '« $text »');

  Future<void> tapIcon(IconData icon) => tap(find.byIcon(icon), what: 'icône $icon');

  /// Une saisie au clavier dans un champ, repéré par son libellé.
  Future<void> type(String label, String text) async {
    final field = this.field(label);
    await waitFor(field, what: 'champ « $label »');
    await tester.enterText(field, text);
    await tick();
  }

  /// Entrée dans un champ (après [type]).
  Future<void> submit(String label) async {
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tick();
  }

  /// Le champ de saisie au libellé [label].
  Finder field(String label) => find.widgetWithText(TextField, label).first;

  /// Ce que le champ [label] affiche.
  String valueOf(String label) => tester.widget<TextField>(field(label)).controller!.text;

  /// Choisit une page dans le rail de gauche.
  Future<void> goTo(String label) async {
    await tap(find.descendant(of: find.byType(NavigationRail), matching: find.text(label)), what: 'rail « $label »');
    await settle();
  }

  /// Allume ou éteint l'interrupteur à côté de [label].
  Future<void> toggle(String label) async {
    final row = find.ancestor(of: find.text(label), matching: find.byType(Row)).first;
    await tap(find.descendant(of: row, matching: find.byType(Switch)), what: 'interrupteur « $label »');
  }

  /// L'interrupteur du `SwitchListTile` titré [label].
  Future<void> toggleTile(String label) async {
    await tap(find.ancestor(of: find.text(label), matching: find.byType(SwitchListTile)), what: 'interrupteur « $label »');
  }

  /// La douchette : chaque caractère est une touche, puis Entrée. Les touches sont celles de
  /// Windows, la cible de l'application — le chemin réel de `ScannerListener`.
  Future<void> scan(String code) async {
    for (final char in code.split('')) {
      await tester.sendKeyEvent(_keyOf(char), platform: 'windows');
    }
    await tester.sendKeyEvent(LogicalKeyboardKey.enter, platform: 'windows');
    await settle();
  }

  static LogicalKeyboardKey _keyOf(String char) {
    if (char == '-') return LogicalKeyboardKey.minus;
    final code = char.toLowerCase().codeUnitAt(0);
    if (code >= 0x30 && code <= 0x39) return LogicalKeyboardKey(LogicalKeyboardKey.digit0.keyId + code - 0x30);
    if (code >= 0x61 && code <= 0x7a) return LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + code - 0x61);
    throw ArgumentError('Caractère sans touche : $char');
  }

  /// Le message de la barre de scan.
  Future<void> seeScan(String text) => see(text);

  /// Ferme le toast par sa croix.
  Future<void> closeToast() => tap(find.descendant(of: find.byType(Toast), matching: find.byIcon(Icons.close)), what: 'croix du toast');

  /// Le texte d'une carte : les billes de sessions, bonus, jetons d'un joueur.
  Finder card(int number) => find.ancestor(of: find.descendant(of: find.byType(CircleAvatar), matching: find.text(number.toString())), matching: find.byType(Card)).first;

  /// Un `DateTimeFormField` : le clic ouvre le calendrier de Flutter — constaté, puis fermé —
  /// et la valeur est posée sur le champ. Les dialogues de Flutter ne se jouent pas au clavier
  /// en test de widget (L18, C8).
  Future<void> pickDateTime(String label, DateTime value) async {
    await tap(find.ancestor(of: find.text(label), matching: find.byType(InkWell)), what: 'champ « $label »');
    await waitFor(find.byType(DatePickerDialog), what: 'calendrier');
    await tapText(s.utils_button_cancel);
    await waitGone(find.byType(DatePickerDialog), what: 'calendrier');
    final field = find.ancestor(of: find.text(label), matching: find.byType(DateTimeFormField));
    tester.state<FormFieldState<DateTime>>(field).didChange(value);
    await tick();
    final hm = '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
    await waitFor(find.textContaining(hm), what: 'heure choisie $hm');
  }

  /// Ouvre le sélecteur d'événement de la barre du haut et choisit [name] dans la vue de
  /// recherche — la dernière occurrence : la vue est au-dessus de la page, qui peut lister le
  /// même nom.
  Future<void> chooseEvent(String name) async {
    await tap(find.descendant(of: find.byType(AppBar), matching: find.byType(InputDecorator)), what: 'sélecteur d\'événement');
    await waitFor(find.byType(SearchBar), what: 'vue de recherche');
    await tester.tap(find.widgetWithText(ListTile, name).last);
    await settle();
  }
}

extension AppDebug on App {
  /// Les textes à l'écran, pour lire un échec.
  String screen() => find.byType(Text).evaluate()
    .map((e) => (e.widget as Text).data ?? (e.widget as Text).textSpan?.toPlainText() ?? '')
    .where((t) => t.isNotEmpty)
    .join(' | ');
}

/// Les dialogues « où écrire » et « quel fichier ouvrir », sans le système : le test pose les
/// chemins. Comme le vrai, « où écrire » écrit la première version.
class FakeBackupFilePicker extends BackupFilePicker {
  String? savePath;
  String? openPath;

  @override
  Future<String?> chooseSavePath(String suggestedName, Uint8List bytes) async {
    final path = savePath;
    if (path != null) await File(path).writeAsBytes(bytes);
    return path;
  }

  @override
  Future<String?> chooseOpenPath() async => openPath;
}
