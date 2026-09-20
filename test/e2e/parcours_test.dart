import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/ui/pages/card_generator/card_sheet_preview.dart';
import 'package:printing/printing.dart';

import '../isar_test_support.dart';
import 'app_test_support.dart';

/// L18 — le parcours : une édition jouée de bout en bout sur la vraie application, gestes de
/// `docs/gestes.md` à l'appui. Une seule base, d'une étape à l'autre, comme en salle.
void main() {
  late Isar isar;

  setUpAll(() async {
    isar = await openTestIsar();
  });

  testWidgets('parcours', (tester) async {
    final app = await App.launch(tester, isar);
    final s = app.s;

    // L'événement A commence il y a 65 minutes, sessions de 15 min toutes les 15 min : quatre
    // passées, la cinquième ouverte (depuis 5 min, pour 10 min encore), sept à venir.
    final now = DateTime.now();
    final startA = DateTime(now.year, now.month, now.day, now.hour, now.minute).subtract(const Duration(minutes: 65));
    final endA = startA.add(const Duration(hours: 3));

    await app.run('1 — Base vide', () async {
      app.g('TR-1');
      expect(find.byTooltip(s.widget_mainRail_createEventFirst), findsNWidgets(5));
      await app.goTo(s.page_playerList_menuItem);
      await app.see(s.page_eventList_title);
      expect(find.text(s.page_playerList_playerCount), findsNothing);

      app.g('EV-1');
      await app.see(s.page_eventList_empty_text);
      await app.tap(find.widgetWithText(FilledButton, s.page_eventList_empty_title));
      await app.see(s.editor_title_event_create);

      app.g('EV-3');
      await app.tapText(s.utils_button_save);
      await app.see(s.data_event_error_name_required);
      await app.type(s.data_event_name, 'Marathon A');
      await app.pickDateTime(s.data_event_datetime_start, startA);
      await app.pickDateTime(s.data_event_datetime_end, endA);
      await app.type(s.data_event_session_duration_minute, '15');
      await app.type(s.data_event_session_interval_minute, '15');

      app.g('EV-4');
      await app.toggleTile(s.data_event_protectCards);
      expect(tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value, isTrue);

      app.g('EV-9');
      await app.tapText(s.utils_button_save);
      await app.waitGone(find.text(s.editor_title_event_create));
      await app.see('Marathon A');

      app.g('EV-8');
      final sessions = await tester.runAsync(() => isar.sessions.where().sortByNumber().findAll());
      expect(sessions!.map((x) => x.number), List.generate(12, (i) => i + 1));
      expect(sessions.first.startTime, startA);
      expect(sessions.first.endTime, startA.add(const Duration(minutes: 15)));

      app.g('TR-2');
      expect(find.byTooltip(s.widget_mainRail_createEventFirst), findsNothing);
      await app.chooseEvent('Marathon A');
      await app.goTo(s.page_playerList_menuItem);
      await app.see(s.page_playerList_playerCount);
    });

    Future<Event> eventA() async => (await tester.runAsync(() => isar.events.filter().nameEqualTo('Marathon A').findFirst()))!;
    Future<Player> player(int number) async => (await tester.runAsync(() => isar.players.filter().numberEqualTo(number).findFirst()))!;
    final inDrawer = find.byType(Drawer);

    await app.run('2 — Joueurs, cycle 1', () async {
      app.g('JO-1');
      await app.type(s.page_playerList_playerCount, '20');
      await app.tapText(s.page_playerList_generateMissingPlayers);
      await app.waitFor(app.card(20), what: 'carte du joueur 20');
      expect(find.byType(Card), findsNWidgets(20));
      final event = await eventA();
      expect((await player(7)).qrcode, event.qrCodeFor(7));
      expect(event.qrSalt.length, 8);
      await app.type(s.page_playerList_playerCount, '10');
      await app.see(s.page_playerList_alreadyExisting(20));
      expect(tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, s.page_playerList_generateMissingPlayers)).onPressed, isNull);

      app.g('JO-6');
      final card1 = app.card(1);
      Color? numberBubble(Finder card) => tester.widget<CircleAvatar>(find.descendant(of: card, matching: find.byType(CircleAvatar)).first).backgroundColor;
      final grey = Theme.of(tester.element(card1)).colorScheme.surfaceContainerHighest;
      expect(numberBubble(card1), grey, reason: 'sans jeton, la bille du numéro est grise');
      expect(find.descendant(of: card1, matching: find.text(s.data_session_objName(0))), findsOneWidget);
      expect(find.descendant(of: card1, matching: find.text(s.data_player_bonus)), findsOneWidget);
      expect(find.descendant(of: card1, matching: find.text(s.data_player_tokens(0))), findsOneWidget);

      app.g('JO-2');
      final plus = find.descendant(of: card1, matching: find.byIcon(Icons.add));
      final minus = find.descendant(of: card1, matching: find.byIcon(Icons.remove));
      expect(tester.widget<IconButton>(find.ancestor(of: minus, matching: find.byType(IconButton))).onPressed, isNull);
      await app.tap(plus);
      await app.tap(plus);
      expect(find.descendant(of: card1, matching: find.text(s.data_player_tokens(2))), findsOneWidget);
      expect(numberBubble(card1), isNot(grey), reason: 'avec des jetons, la bille reprend sa couleur');
      app.g('JO-3');
      await app.tap(minus);
      expect(find.descendant(of: card1, matching: find.text(s.data_player_tokens(1))), findsOneWidget);
      await app.wait(const Duration(milliseconds: 500));
      await app.until(() async => (await isar.players.filter().numberEqualTo(1).findFirst())!.bonusSession == 1, what: 'bonus du joueur 1 écrit');

      app.g('JO-4');
      await app.tap(app.card(2));
      await app.see(s.editor_title_player);
      expect(find.descendant(of: inDrawer, matching: find.text('2')), findsWidgets);

      app.g('JO-7');
      await app.type(s.data_player_name, '');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.see(s.data_player_error_name_required);
      await app.type(s.data_player_name, 'Deux');
      app.g('JO-8');
      await app.tap(find.descendant(of: inDrawer, matching: find.byIcon(Icons.add)));
      expect(tester.widget<TextField>(app.field(s.data_player_bonus)).controller!.text, '1');
      expect((await player(2)).bonusSession, 0);
      app.g('JO-9');
      await app.toggle(s.page_session_manualAdd);
      app.g('JO-10');
      final sessionCard1 = find.descendant(of: inDrawer, matching: find.widgetWithText(ListTile, '1')).first;
      await app.tap(sessionCard1);
      Color? avatarColor(Finder tile) => tester.widget<CircleAvatar>(find.descendant(of: tile, matching: find.byType(CircleAvatar))).backgroundColor;
      expect(avatarColor(sessionCard1), Colors.green);
      expect((await player(2)).sessions.length, 0);
      app.g('JO-13');
      expect(find.descendant(of: inDrawer, matching: find.text(s.form_player_legend_manual)), findsOneWidget);
      app.g('JO-11');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.waitGone(inDrawer);
      final p2 = await player(2);
      await tester.runAsync(() => p2.sessions.load());
      expect(p2.name, 'Deux');
      expect(p2.bonusSession, 1);
      expect(p2.sessions.map((x) => x.number), [1]);
      await app.see('Deux');
      await app.waitFor(find.descendant(of: app.card(2), matching: find.text(s.data_player_tokens(2))), what: 'la carte du joueur 2 compte 2 jetons');

      app.g('JO-12');
      await app.tap(app.card(3));
      await app.type(s.data_player_name, 'Trois');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      app.g('TR-3');
      await app.see(s.editor_dirty_title);
      await app.tapText(s.editor_dirty_stay);
      await app.dontSee(s.editor_dirty_title);
      expect(inDrawer, findsOneWidget);
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.tapText(s.editor_dirty_leave);
      await app.waitGone(inDrawer);
      expect((await player(3)).name, '3');

      app.g('JO-5');
      await app.scan(event.qrCodeFor(4));
      await app.see(s.scan_opened(4));
      await app.see(s.editor_title_player);
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);
      expect((await player(4)).sessions.length, 0);

      app.g('TR-4');
      await app.scan('99');
      await app.see(s.scan_invalidCard);
      expect(inDrawer, findsNothing);
      app.g('CA-8');
      await app.scan('autresel-4');
      await app.see(s.scan_invalidCard);
    });

    Future<int> playerCount() async => (await tester.runAsync(() => isar.players.count()))!;
    // Les sessions de A — même renommé « Marathon A bis » (étape 8).
    Future<List<int>> sessionIds() async => (await tester.runAsync(() => isar.sessions.filter().event((q) => q.nameStartsWith('Marathon A')).idProperty().findAll()))!;

    await app.run('3 — Supprimer et recréer', () async {
      final oldSalt = (await eventA()).qrSalt;
      final oldSessions = await sessionIds();

      app.g('EV-2');
      await app.goTo(s.page_eventList_menuItem);
      await app.tap(find.widgetWithText(ListTile, 'Marathon A'));
      await app.see(s.editor_title_event_edit);
      expect(app.valueOf(s.data_event_name), 'Marathon A');

      app.g('EV-4');
      final protection = find.byType(SwitchListTile);
      await app.see(s.data_event_protectCards_locked);
      expect(tester.widget<SwitchListTile>(protection).onChanged, isNull);
      expect(tester.widget<SwitchListTile>(protection).value, isTrue);
      expect(find.text(s.data_event_recoverSalt), findsNothing);

      app.g('EV-7');
      await app.tapText(s.page_playerList_deletePlayers);
      await app.see(s.data_event_deletePlayers_confirm(20));
      await app.tapText(s.utils_button_cancel);
      await app.dontSee(s.data_event_deletePlayers_confirm(20));
      expect(await playerCount(), 20);
      await app.tapText(s.page_playerList_deletePlayers);
      await app.tap(find.widgetWithText(FilledButton, s.utils_button_delete));
      await app.until(() async => await isar.players.count() == 0, what: 'plus aucun joueur');
      await app.waitFor(find.text(s.data_event_recoverSalt), what: 'bouton Récupérer la protection');
      expect(tester.widget<SwitchListTile>(protection).onChanged, isNotNull);

      app.g('EV-5');
      await app.toggleTile(s.data_event_protectCards);
      expect(tester.widget<SwitchListTile>(protection).value, isFalse);

      app.g('EV-6');
      await app.tapText(s.data_event_recoverSalt);
      await app.see(s.data_event_recoverSalt_scan);
      await app.scan('7');
      app.g('TR-5');
      await app.see(s.data_event_recoverSalt_none);
      await app.closeToast();
      await app.dontSee(s.data_event_recoverSalt_none);
      expect(tester.widget<SwitchListTile>(protection).value, isFalse);
      app.g('EV-6');
      await app.tapText(s.data_event_recoverSalt);
      await app.see(s.data_event_recoverSalt_scan);
      await app.scan('$oldSalt-3');
      await app.dontSee(s.data_event_recoverSalt_scan);
      expect(tester.widget<SwitchListTile>(protection).value, isTrue);

      app.g('EV-9');
      await app.tapText(s.utils_button_save);
      await app.waitGone(inDrawer);
      expect((await eventA()).qrSalt, oldSalt);
      app.g('EV-8');
      expect(await sessionIds(), oldSessions);

      app.g('JO-1');
      await app.goTo(s.page_playerList_menuItem);
      await app.type(s.page_playerList_playerCount, '20');
      await app.tapText(s.page_playerList_generateMissingPlayers);
      await app.waitFor(app.card(20), what: 'carte du joueur 20');
      expect((await player(5)).qrcode, '$oldSalt-5');
    });

    await app.run('4 — Générateur', () async {
      // Q2 : l'image de fond est posée en base par le test, le sélecteur de fichier étant
      // un dialogue du système.
      final image = await tester.runAsync(() => pngImage(40, 60));
      await tester.runAsync(() async {
        final event = (await isar.events.filter().nameEqualTo('Marathon A').findFirst())!..playerCardBackgroundImage = image;
        await isar.writeTxn(() => isar.events.put(event));
      });
      // L'événement sélectionné se relit après l'écriture : la page doit voir l'image.
      await app.settle();
      await app.goTo(s.page_cardGenerator_menuItem);
      await app.see(s.page_cardGenerator_section_sheet);
      await app.waitFor(find.byType(CardSheetPreview), what: 'aperçu rapide');
      expect(find.text(s.page_cardGenerator_noImage), findsNothing);
      CardLayout layout() => tester.widget<CardSheetPreview>(find.byType(CardSheetPreview)).layout;

      app.g('CA-2');
      await app.type(s.page_cardGenerator_cardsPerRow, '2');
      await app.type(s.page_cardGenerator_rowsPerPage, '2');
      await app.type(s.page_cardGenerator_cardWidth, '50');
      expect(layout().settings.cardsPerRow, 2);
      expect(layout().settings.rowsPerPage, 2);
      expect(layout().settings.cardWidth, 50);
      await app.see(s.page_cardGenerator_cardHeight(75));
      await app.see(s.page_cardGenerator_summary(20, 1, 20, 5));
      app.g('CA-3');
      await app.type(s.page_cardGenerator_size, '20');
      expect(layout().settings.qrCodeSize, 20);
      app.g('CA-4');
      await app.type(s.page_cardGenerator_fontSize, '10');
      expect(layout().settings.idFontSize, 10);

      app.g('CA-5');
      await app.type(s.page_cardGenerator_to, '30');
      await app.see(s.page_cardGenerator_summary(32, 1, 32, 8));
      await app.see(s.page_cardGenerator_playerCount(20));
      await app.tapText(s.page_cardGenerator_generateExtraPlayers);
      await app.until(() async => await isar.players.count() == 30, what: '30 joueurs');
      await app.see(s.page_cardGenerator_playerCount(30));
      await app.dontSee(s.page_cardGenerator_generateExtraPlayers);
      expect((await player(30)).qrcode, (await eventA()).qrCodeFor(30));

      // CA-6 : la bascule seulement. Le rendu PDF passe par le module natif d'impression,
      // absent en test de widget — l'aperçu tourne sans fin, on ne l'attend pas (recette).
      app.g('CA-6');
      await tester.tap(find.text(s.page_cardGenerator_pdfPreview));
      await tester.pump();
      expect(find.byType(PdfPreview), findsOneWidget);
      expect(find.byType(CardSheetPreview), findsNothing);
      await tester.tap(find.text(s.page_cardGenerator_quickPreview));
      await tester.pump();
      await app.waitFor(find.byType(CardSheetPreview), what: 'aperçu rapide');

      app.g('CA-7');
      await app.tapText(s.utils_button_save);
      app.g('TR-5');
      await app.see(s.page_cardGenerator_saved);
      await app.until(() async {
        final e = (await isar.events.filter().nameEqualTo('Marathon A').findFirst())!;
        return e.playerCardsPerRow == 2 && e.playerCardRowsPerPage == 2 && e.qrCodeSize == 20 && e.idFontSize == 10 && e.playerCardBackgroundImage != null;
      }, what: 'réglages écrits sur l\'événement');
      await app.wait(const Duration(seconds: 3));
      expect(find.text(s.page_cardGenerator_saved), findsNothing);

      app.g('TR-4');
      await app.scan((await eventA()).qrCodeFor(25));
      await app.see(s.scan_opened(25));
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);
    });

    Future<PlayerGroup?> group(String name) async => await tester.runAsync<PlayerGroup?>(() => isar.playerGroups.filter().nameEqualTo(name).findFirst());
    Future<int> memberCount(String name) async {
      final g = (await group(name))!;
      await tester.runAsync(() => g.players.load());
      return g.players.length;
    }

    await app.run('5 — Groupes', () async {
      final event = await eventA();
      final removeSwitch = find.descendant(of: find.ancestor(of: find.text(s.page_session_removeMode), matching: find.byType(Row)).first, matching: find.byType(Switch));

      app.g('GR-1');
      await app.goTo(s.page_playerGroupsList_menuItem);
      await app.see(s.page_playerGroupsList_help_winners);
      await app.tap(find.byType(FloatingActionButton));
      await app.see(s.editor_title_playerGroup_create);

      app.g('GR-2');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.see(s.data_playerGroup_error_name_required);
      await app.type(s.data_playerGroup_name, 'Les amis');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.waitGone(inDrawer);
      await app.see('Les amis');
      expect(await memberCount('Les amis'), 0);

      app.g('GR-3');
      await app.tap(find.widgetWithText(ListTile, 'Les amis'));
      await app.see('${s.page_playerGroup_title} : Les amis');
      await app.see(s.page_playerGroup_members(0));
      // TR-4 : le dernier retour de scan (étape 4) suit d'une page à l'autre.
      app.g('TR-4');
      await app.seeScan(s.scan_opened(25));

      app.g('GR-5');
      await app.scan(event.qrCodeFor(1));
      await app.seeScan(s.scan_addedToGroup(1));
      await app.see(s.page_playerGroup_members(1));
      await app.scan(event.qrCodeFor(1));
      await app.seeScan(s.scan_alreadyInGroup(1));
      await app.see(s.page_playerGroup_members(1));

      app.g('GR-10');
      await app.type(s.page_playerGroup_addByNumber, '2');
      await app.tapText(s.utils_button_add);
      await app.see(s.page_playerGroup_members(2));
      await app.see(s.scan_addedToGroup(2));
      expect(app.valueOf(s.page_playerGroup_addByNumber), '');
      await app.type(s.page_playerGroup_addByNumber, '99');
      await app.tapText(s.utils_button_add);
      await app.see(s.page_session_number_unknown(99));
      await app.type(s.page_playerGroup_addByNumber, '1');
      await app.tapText(s.utils_button_add);
      await app.see(s.page_playerGroup_alreadyMember(1));
      await app.see(s.page_playerGroup_members(2));

      app.g('GR-6');
      await app.tap(removeSwitch);
      await app.seeScan(s.scan_hint_removeFromGroup);
      expect(find.text(s.page_session_remove), findsNWidgets(2));
      await app.tapText(s.page_session_remove);
      await app.see(s.page_playerGroup_members(1));
      await app.scan(event.qrCodeFor(3));
      await app.seeScan(s.scan_notInGroup(3));
      await app.scan(event.qrCodeFor(2));
      await app.seeScan(s.scan_removedFromGroup(2));
      await app.see(s.page_playerGroup_members(0));
      expect(await memberCount('Les amis'), 0);
      await app.tap(removeSwitch);
      await app.seeScan(s.scan_hint_addToGroup);
      expect(find.text(s.page_session_remove), findsNothing);

      app.g('GR-11');
      await app.tap(find.descendant(of: find.byType(AppBar), matching: find.byIcon(Icons.edit)));
      await app.see(s.editor_title_playerGroup_edit);
      expect(app.valueOf(s.data_playerGroup_name), 'Les amis');
      await app.type(s.data_playerGroup_name, 'Les copains');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.waitGone(inDrawer);
      await app.see('${s.page_playerGroup_title} : Les copains');

      app.g('GR-9');
      await app.tap(find.descendant(of: find.byType(AppBar), matching: find.byIcon(Icons.edit)));
      await app.type(s.data_playerGroup_name, 'Autre');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.see(s.editor_dirty_title);
      await app.tapText(s.editor_dirty_leave);
      await app.waitGone(inDrawer);
      expect(await group('Les copains'), isNotNull);

      app.g('GR-4');
      await app.tapIcon(Icons.arrow_back);
      await app.see(s.page_playerGroupsList_title);
      await app.scan(event.qrCodeFor(5));
      await app.seeScan(s.scan_opened(5));
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);

      app.g('GR-7');
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Les copains'), matching: find.byIcon(Icons.delete)));
      await app.see(s.data_playerGroup_delete_confirm('Les copains'));
      await app.tapText(s.utils_button_cancel);
      await app.dontSee(s.data_playerGroup_delete_confirm('Les copains'));
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Les copains'), matching: find.byIcon(Icons.delete)));
      await app.tap(find.widgetWithText(FilledButton, s.utils_button_delete));
      await app.waitGone(find.text('Les copains'));
      expect(await group('Les copains'), isNull);
      expect(await playerCount(), 30);

      // Le groupe qui servira aux tirages (étape 7) : les habitués, joueurs 1 à 3.
      app.g('GR-2');
      await app.tap(find.byType(FloatingActionButton));
      await app.type(s.data_playerGroup_name, 'Habitués');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.waitGone(inDrawer);
      await app.tap(find.widgetWithText(ListTile, 'Habitués'));
      app.g('GR-10');
      for (final n in ['1', '2', '3']) {
        await app.type(s.page_playerGroup_addByNumber, n);
        await app.submit(s.page_playerGroup_addByNumber);
        await app.see(s.page_playerGroup_members(int.parse(n)));
        await app.settle();
      }
      expect(await memberCount('Habitués'), 3);
      await app.tapIcon(Icons.arrow_back);
    });

    // Lectures de la base : `presentIn` s'appelle dans `until` (déjà hors horloge), `present` partout ailleurs.
    // Les sessions de A (B a les mêmes numéros).
    Future<Session?> sessionOfA(int number) => isar.sessions.filter().numberEqualTo(number).event((q) => q.nameStartsWith('Marathon A')).findFirst();
    Future<Session> session(int number) async => (await tester.runAsync(() => sessionOfA(number)))!;
    Future<Set<int>> presentIn(int sessionNumber) async {
      final x = (await sessionOfA(sessionNumber))!;
      await x.players.load();
      return x.players.map((p) => p.number).toSet();
    }
    Future<Set<int>> present(int sessionNumber) async => (await tester.runAsync(() => presentIn(sessionNumber)))!;
    Finder sessionCard(int number) => find.ancestor(of: find.descendant(of: find.byType(CircleAvatar), matching: find.text(number.toString())), matching: find.byType(Card)).first;
    final hm = DateFormat('Hm', 'fr');

    await app.run('6 — Sessions', () async {
      final event = await eventA();
      final removeSwitch = find.descendant(of: find.ancestor(of: find.text(s.page_session_removeMode), matching: find.byType(Row)).first, matching: find.byType(Switch));
      final manualSwitch = find.descendant(of: find.ancestor(of: find.text(s.page_session_manualAdd), matching: find.byType(Row)).first, matching: find.byType(Switch));
      Finder presentCount(int sessionNumber, int count) => find.descendant(of: sessionCard(sessionNumber), matching: find.descendant(of: find.byType(CircleAvatar), matching: find.text(count.toString())));

      app.g('SE-1');
      await app.goTo(s.page_sessionList_menuItem);
      await app.waitFor(sessionCard(12), what: 'carte de la session 12');
      final scheme = Theme.of(tester.element(find.byType(NavigationRail))).colorScheme;
      expect(tester.widget<Card>(sessionCard(5)).color, scheme.primaryContainer, reason: 'session 5 ouverte');
      expect(tester.widget<Card>(sessionCard(1)).color, Colors.grey.shade400, reason: 'session 1 passée');
      expect(tester.widget<Card>(sessionCard(8)).color, isNull, reason: 'session 8 à venir');
      await app.see(s.page_sessionList_legend_open);
      expect(find.textContaining(RegExp(r'^\d{2}:\d{2}:\d{2}$')), findsOneWidget, reason: 'horloge');
      expect(presentCount(5, 0), findsOneWidget);
      app.g('SE-7');
      expect(find.textContaining('énérer'), findsNothing, reason: 'ni générer ni supprimer les sessions ici');

      app.g('SE-2');
      await app.scan(event.qrCodeFor(6));
      await app.seeScan(s.scan_badged(6, 5));
      await app.waitFor(presentCount(5, 1), what: '1 présent sur la session 5');
      await app.scan(event.qrCodeFor(6));
      await app.seeScan(s.scan_alreadyPresent(6, 5));
      expect(await present(5), {6});

      // La session 8, à venir : rien ne se badge sans le badgeage manuel.
      app.g('SE-3');
      await app.tap(sessionCard(8));
      final s8 = await session(8);
      await app.see(s.page_session_header(hm.format(s8.endTime), 8, hm.format(s8.startTime)));
      expect(find.textContaining(s.page_session_state_open), findsNothing);
      app.g('SE-4');
      await app.scan(event.qrCodeFor(8));
      await app.seeScan(s.scan_sessionNotOpen);
      app.g('SE-8');
      expect(tester.widget<TextField>(app.field(s.page_session_number)).enabled, isFalse);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, s.utils_button_add)).onPressed, isNull);
      app.g('SE-5');
      await app.tap(manualSwitch);
      expect(tester.widget<TextField>(app.field(s.page_session_number)).enabled, isTrue);
      await app.scan(event.qrCodeFor(8));
      await app.seeScan(s.scan_badged(8, 8));
      await app.scan(event.qrCodeFor(8));
      await app.seeScan(s.scan_alreadyPresent(8, 8));
      expect(await present(8), {8});
      await app.tapIcon(Icons.arrow_back);

      // La session 5, ouverte : le joueur 6 est présent, le 8 a badgé ailleurs.
      app.g('SE-3');
      final s5 = await session(5);
      await app.tap(sessionCard(5));
      await app.see('${s.page_session_header(hm.format(s5.endTime), 5, hm.format(s5.startTime))} — ${s.page_session_state_open}');
      await app.see(s.page_session_zone_present(1));
      await app.see(s.page_session_zone_absent(1));
      await app.see(s.page_session_help_absent);
      expect(find.text(s.page_session_number), findsOneWidget);
      expect(find.text(s.utils_button_add), findsOneWidget);

      app.g('SE-4');
      await app.scan(event.qrCodeFor(7));
      await app.seeScan(s.scan_badged(7, 5));
      await app.see(s.page_session_zone_present(2));
      await app.scan(event.qrCodeFor(7));
      await app.seeScan(s.scan_alreadyPresent(7, 5));

      // Le joueur 8 quitte Absents pour Présents (l'animation se joue, le compte suit).
      app.g('SE-9');
      await app.scan(event.qrCodeFor(8));
      await app.seeScan(s.scan_badged(8, 5));
      await app.see(s.page_session_zone_present(3));
      await app.see(s.page_session_zone_absent(0));

      app.g('SE-8');
      await app.type(s.page_session_number, '9');
      await app.tapText(s.utils_button_add);
      await app.see(s.scan_badged(9, 5));
      await app.see(s.page_session_zone_present(4));
      expect(app.valueOf(s.page_session_number), '');
      await app.type(s.page_session_number, '99');
      await app.tapText(s.utils_button_add);
      await app.see(s.page_session_number_unknown(99));
      await app.type(s.page_session_number, '9');
      await app.submit(s.page_session_number);
      await app.see(s.scan_alreadyPresent(9, 5));
      expect(await present(5), {6, 7, 8, 9});

      app.g('SE-6');
      await app.tap(removeSwitch);
      await app.seeScan(s.scan_hint_removeFromSession);
      expect(find.text(s.page_session_remove), findsNWidgets(4));
      await app.tapText(s.page_session_remove);
      await app.see(s.page_session_zone_present(3));
      await app.until(() async => !(await presentIn(5)).contains(6), what: 'joueur 6 retiré');
      expect(find.text(s.page_session_zone_absent(0)), findsOneWidget, reason: 'le joueur 6 n\'a badgé nulle part ailleurs');
      await app.scan(event.qrCodeFor(7));
      await app.seeScan(s.scan_removedFromSession(7, 5));
      await app.scan(event.qrCodeFor(2));
      await app.seeScan(s.scan_notPresent(2, 5));
      await app.see(s.page_session_zone_present(2));

      app.g('SE-10');
      expect(find.widgetWithText(FilledButton, s.utils_button_delete), findsOneWidget);
      expect(find.widgetWithText(FilledButton, s.utils_button_add), findsNothing);
      await app.type(s.page_session_number, '9');
      await app.tapText(s.utils_button_delete);
      await app.see(s.scan_removedFromSession(9, 5));
      await app.see(s.page_session_zone_present(1));
      await app.type(s.page_session_number, '2');
      await app.tapText(s.utils_button_delete);
      await app.see(s.scan_notPresent(2, 5));
      await app.type(s.page_session_number, '99');
      await app.tapText(s.utils_button_delete);
      await app.see(s.page_session_number_unknown(99));
      await app.tap(removeSwitch);
      await app.seeScan(s.scan_hint_badgeThisSession);
      expect(find.text(s.page_session_remove), findsNothing);

      // Les présents de la session 5 pour les tirages (étape 7) : 1, 3, 6 et 8.
      app.g('SE-8');
      for (final n in ['1', '3', '6']) {
        await app.type(s.page_session_number, n);
        await app.tapText(s.utils_button_add);
        await app.see(s.scan_badged(int.parse(n), 5));
        await app.settle();
      }
      expect(await present(5), {1, 3, 6, 8});
      await app.tapIcon(Icons.arrow_back);

      // L'événement B, la veille : aucune session ouverte.
      app.g('EV-1');
      await app.goTo(s.page_eventList_menuItem);
      await app.tap(find.byType(FloatingActionButton));
      await app.type(s.data_event_name, 'Marathon B');
      await app.pickDateTime(s.data_event_datetime_start, startA.subtract(const Duration(days: 1)));
      await app.pickDateTime(s.data_event_datetime_end, endA.subtract(const Duration(days: 1)));
      await app.tapText(s.utils_button_save);
      await app.waitGone(inDrawer);
      app.g('TR-2');
      await app.chooseEvent('Marathon B');
      await app.goTo(s.page_playerList_menuItem);
      await app.type(s.page_playerList_playerCount, '5');
      await app.tapText(s.page_playerList_generateMissingPlayers);
      await app.waitFor(app.card(5), what: 'carte du joueur 5 de B');
      expect(find.byType(Card), findsNWidgets(5));
      app.g('SE-2');
      await app.goTo(s.page_sessionList_menuItem);
      await app.waitFor(sessionCard(3), what: 'sessions de B (trois, une par heure)');
      await app.scan('3');
      await app.seeScan(s.scan_noOpenSession);
      app.g('TR-2');
      await app.chooseEvent('Marathon A');
      await app.goTo(s.page_playerList_menuItem);
      await app.waitFor(app.card(30), what: 'les 30 joueurs de A');
    });

    Future<Draw?> draw(String name) async => await tester.runAsync<Draw?>(() => isar.draws.filter().nameEqualTo(name).findFirst());
    // Les compteurs de l'éditeur de tirage : la bille et son libellé, sur la même ligne.
    Finder players(int n) => find.ancestor(of: find.text(s.data_draw_playerCount(n)), matching: find.byType(ListTile)).first;
    Future<void> seeCounters(int nPlayers, int tokens) async {
      await app.waitFor(find.descendant(of: players(nPlayers), matching: find.text(nPlayers.toString())), what: '$nPlayers joueurs sélectionnés');
      await app.see(s.data_draw_tokenCount(tokens));
    }
    // Un sélecteur multiple (groupes, sessions) : ouvrir, cocher, refermer par la flèche.
    Future<void> pick(String label, List<String> items) async {
      await app.tap(find.ancestor(of: find.text(label), matching: find.byType(InkWell)), what: 'sélecteur « $label »');
      await app.waitFor(find.byType(SearchBar), what: 'vue du sélecteur');
      for (final item in items) {
        await app.tap(find.descendant(of: find.byType(Card), matching: find.text(item)).last, what: '« $item »');
      }
      await app.tapIcon(Icons.arrow_back);
      await app.waitGone(find.byType(SearchBar));
    }
    const winnersGroupName = 'Gagnants du tirage « Tirage N°1 »';

    await app.run('7 — Tirages', () async {
      final event = await eventA();

      app.g('TI-11');
      await app.goTo(s.page_drawList_menuItem);
      await app.see(s.page_drawList_title);
      expect(find.byType(SearchBar), findsNothing);

      app.g('TI-1');
      await app.tap(find.byType(FloatingActionButton));
      await app.see(s.editor_title_draw_create);
      expect(app.valueOf(s.data_draw_name), 'Tirage N°1');
      expect(app.valueOf(s.data_draw_winnerCount), '1');
      expect(app.valueOf(s.data_draw_minSessionNumber), '1');
      await app.see('12');
      app.g('TI-6');
      await seeCounters(0, 0);
      app.g('TI-12');
      expect(find.descendant(of: inDrawer, matching: find.text(s.utils_button_delete)), findsNothing);

      app.g('TI-5');
      // Présents de la session 5 : 1, 3, 6 (un jeton chacun, les bonus ont disparu avec les joueurs
      // de l'étape 3) et 8 (deux sessions).
      await pick(s.data_draw_requiredSessions, ['5', '12']);
      await seeCounters(4, 5);
      app.g('TI-3');
      await app.type(s.data_draw_minSessionNumber, '2');
      await seeCounters(1, 2);
      await app.type(s.data_draw_minSessionNumber, '1');
      await app.type(s.data_draw_winnerCount, '2');
      await seeCounters(4, 5);
      app.g('TI-4');
      await app.tap(find.ancestor(of: find.text(s.data_draw_requiredPlayers), matching: find.byType(InkWell)), what: 'sélecteur des groupes requis');
      await app.tap(find.widgetWithText(ListTile, 'Habitués').last);
      await app.tapIcon(Icons.arrow_back);
      await app.waitGone(find.byType(SearchBar));
      await seeCounters(2, 2);

      app.g('TI-7');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)));
      await app.waitGone(inDrawer);
      await app.see('Tirage N°1');
      expect(find.textContaining(s.data_draw_drawn), findsNothing);
      expect((await draw('Tirage N°1'))!.isDrawn, isFalse);

      app.g('TI-2');
      await app.tap(find.widgetWithText(ListTile, 'Tirage N°1'));
      await app.see(s.editor_title_draw_edit);
      await app.see('Habitués');
      await app.see('5');
      await seeCounters(2, 2);

      app.g('TI-8');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.data_draw_launch)));
      await app.see(s.data_draw_launch_confirm(2, 2));
      await app.tap(find.widgetWithText(FilledButton, s.data_draw_launch).last); // celui de la modale
      await app.waitGone(inDrawer);
      await app.waitFor(find.textContaining(s.data_draw_drawn), what: '« Tiré le … »');
      await app.see('N°1');
      await app.see('N°2');
      final drawn = (await draw('Tirage N°1'))!;
      expect(drawn.isDrawn, isTrue);
      await tester.runAsync(() => drawn.winners.load());
      expect(drawn.winners.map((w) => w.winner.value!.number).toSet(), {1, 3});
      expect(await group(winnersGroupName), isNotNull);
      expect(await memberCount(winnersGroupName), 2);

      app.g('TI-10');
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Tirage N°1'), matching: find.text('N°1')));
      await app.see(s.editor_title_player);
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);

      app.g('TI-2');
      await app.tap(find.widgetWithText(ListTile, 'Tirage N°1'));
      await app.see(s.editor_title_draw_view);
      await app.see(s.data_draw_drawn_help);
      expect(tester.widget<TextField>(app.field(s.data_draw_name)).enabled, isFalse);
      expect(find.descendant(of: inDrawer, matching: find.text(s.data_draw_launch)), findsNothing);
      expect(find.descendant(of: inDrawer, matching: find.text(s.utils_button_save)), findsNothing);
      app.g('TI-13');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_close)));
      await app.waitGone(inDrawer);

      app.g('TI-9');
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Tirage N°1'), matching: find.byIcon(Icons.copy)));
      await app.see(s.editor_title_draw_create);
      expect(app.valueOf(s.data_draw_name), 'Tirage N°2');
      expect(app.valueOf(s.data_draw_winnerCount), '2');
      await app.see(winnersGroupName);
      await seeCounters(0, 0);
      app.g('GR-8');
      await app.tap(find.ancestor(of: find.text(s.data_draw_excludedPlayers), matching: find.byType(InkWell)), what: 'sélecteur des groupes exclus');
      await app.waitFor(find.byType(SearchBar), what: 'vue du sélecteur');
      await app.waitFor(find.descendant(of: find.widgetWithText(ListTile, winnersGroupName).last, matching: find.byIcon(Icons.emoji_events)), what: 'le groupe des gagnants, avec son trophée');
      expect(find.widgetWithText(ListTile, 'Habitués'), findsWidgets);
      await app.tapIcon(Icons.arrow_back);
      await app.waitGone(find.byType(SearchBar));
      app.g('TI-13');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);
      expect(await draw('Tirage N°2'), isNull);
      await app.tap(find.byType(FloatingActionButton));
      await app.type(s.data_draw_name, 'Brouillon');
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.see(s.editor_dirty_title);
      await app.tapText(s.editor_dirty_leave);
      await app.waitGone(inDrawer);
      expect(await draw('Brouillon'), isNull);

      app.g('TR-4');
      await app.scan(event.qrCodeFor(3));
      await app.seeScan(s.scan_opened(3));
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);

      app.g('GR-8');
      await app.goTo(s.page_playerGroupsList_menuItem);
      await app.see('Habitués');
      await app.dontSee(winnersGroupName);
      app.g('GR-7');
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Habitués'), matching: find.byIcon(Icons.delete)));
      await app.see(s.data_playerGroup_usedByDraws(1));
      await app.tapText(s.utils_button_close);
      await app.dontSee(s.data_playerGroup_usedByDraws(1));
      expect(await group('Habitués'), isNotNull);
      await app.tap(find.descendant(of: find.widgetWithText(ListTile, 'Habitués'), matching: find.byIcon(Icons.edit)));
      await app.see(s.editor_title_playerGroup_edit);
      await app.see(s.data_playerGroup_usedByDraws(1));
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, s.utils_button_delete)).onPressed, isNull);
      await app.tap(find.descendant(of: inDrawer, matching: find.text(s.utils_button_cancel)));
      await app.waitGone(inDrawer);
    });

    Future<void> openEventA() async {
      await app.goTo(s.page_eventList_menuItem);
      await app.tap(find.widgetWithText(ListTile, 'Marathon A'));
      await app.see(s.editor_title_event_edit);
    }

    await app.run('8 — Changer les horaires', () async {
      final oldSessions = await sessionIds();
      expect(await present(5), {1, 3, 6, 8});

      app.g('EV-10');
      await openEventA();
      expect(find.descendant(of: inDrawer, matching: find.widgetWithText(FilledButton, s.utils_button_delete)), findsNothing);

      // Le nom seul : rien ne bouge côté sessions.
      app.g('EV-9');
      await app.type(s.data_event_name, 'Marathon A bis');
      await app.tapText(s.utils_button_save);
      await app.waitGone(inDrawer);
      await app.see('Marathon A bis');
      app.g('EV-8');
      expect(await sessionIds(), oldSessions);
      expect(await present(5), {1, 3, 6, 8});
      await app.tap(find.widgetWithText(ListTile, 'Marathon A bis'));
      await app.type(s.data_event_name, 'Marathon A');
      await app.tapText(s.utils_button_save);
      await app.waitGone(inDrawer);
      await app.see('Marathon A');

      // L'intervalle change, des badgeages existent : 4 sur la session 5, 1 sur la 8.
      await openEventA();
      await app.type(s.data_event_session_interval_minute, '30');
      await app.tapText(s.utils_button_save);
      await app.see(s.data_event_regenerateSessions_title);
      await app.see(s.data_event_regenerateSessions_confirm(5));
      await app.tapText(s.data_event_regenerateSessions_revert);
      await app.dontSee(s.data_event_regenerateSessions_title);
      expect(inDrawer, findsOneWidget);
      expect(app.valueOf(s.data_event_session_interval_minute), '15');
      expect(await sessionIds(), oldSessions);
      await app.type(s.data_event_session_interval_minute, '30');
      await app.tapText(s.utils_button_save);
      await app.tapText(s.data_event_regenerateSessions_recreate);
      await app.waitGone(inDrawer);
      await app.until(() async => await isar.sessions.filter().event((q) => q.nameEqualTo('Marathon A')).count() == 6, what: 'six sessions de 30 min');
      expect((await sessionIds()).toSet().intersection(oldSessions.toSet()), isEmpty);
      expect(await present(3), isEmpty);
      expect(await tester.runAsync(() async {
        var badges = 0;
        for (final x in await isar.sessions.where().findAll()) {
          await x.players.load();
          badges += x.players.length;
        }
        return badges;
      }), 0, reason: 'les badgeages sont perdus');

      app.g('EV-11');
      await openEventA();
      await app.type(s.data_event_name, 'Zut');
      await app.tapText(s.utils_button_cancel);
      await app.see(s.editor_dirty_title);
      await app.tapText(s.editor_dirty_leave);
      await app.waitGone(inDrawer);
      await app.see('Marathon A');
      expect(find.text('Zut'), findsNothing);
    });

    await app.run('9 — Cycle 2', () async {
      // La session 3 des nouveaux horaires est l'ouverte : de −5 min à +25 min.
      app.g('EV-7');
      await openEventA();
      await app.tapText(s.page_playerList_deletePlayers);
      await app.tap(find.widgetWithText(FilledButton, s.utils_button_delete));
      await app.until(() async => await isar.players.filter().event((q) => q.nameEqualTo('Marathon A')).count() == 0, what: 'plus aucun joueur de A');
      expect(await tester.runAsync(() => isar.drawWinners.filter().winnerIsNull().count()), 0, reason: 'les gagnants partent avec les joueurs');
      await app.tapText(s.utils_button_cancel);
      await app.waitGone(inDrawer);
      app.g('TI-2');
      await app.goTo(s.page_drawList_menuItem);
      await app.see('Tirage N°1');
      await app.dontSee('N°1');

      app.g('JO-1');
      await app.goTo(s.page_playerList_menuItem);
      await app.type(s.page_playerList_playerCount, '20');
      await app.tapText(s.page_playerList_generateMissingPlayers);
      await app.waitFor(app.card(20), what: 'les 20 joueurs recréés');
      final event = await eventA();

      app.g('SE-2');
      await app.goTo(s.page_sessionList_menuItem);
      await app.waitFor(sessionCard(6), what: 'les six sessions');
      await app.scan(event.qrCodeFor(4));
      await app.seeScan(s.scan_badged(4, 3));
      await app.scan(event.qrCodeFor(5));
      await app.seeScan(s.scan_badged(5, 3));
      expect(await present(3), {4, 5});

      app.g('SE-6');
      await app.tap(sessionCard(3));
      await app.see(s.page_session_zone_present(2));
      await app.toggle(s.page_session_removeMode);
      await app.scan(event.qrCodeFor(4));
      await app.seeScan(s.scan_removedFromSession(4, 3));
      await app.see(s.page_session_zone_present(1));
      await app.until(() async => (await presentIn(3)).length == 1, what: 'un seul présent');
      expect(await present(3), {5});
    });

    await app.finish();
  });
}

/// Une image PNG unie de [width] × [height] pixels, pour le fond des cartes.
Future<Uint8List> pngImage(int width, int height) async {
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawRect(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), Paint()..color = Colors.blue);
  final image = await recorder.endRecording().toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return data!.buffer.asUint8List();
}
