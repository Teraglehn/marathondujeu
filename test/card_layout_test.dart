import 'package:flutter_test/flutter_test.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';

void main() {
  /// Le cas du critère de fin de L05 : image 2:3, 60 mm, 3 × 3, portrait, numéros 1 à 20.
  CardLayout layout({int start = 1, int end = 20, CardSettings? settings}) => CardLayout(
    settings: settings ?? const CardSettings(cardWidth: 60, cardsPerRow: 3, rowsPerPage: 3, landscape: false),
    imageRatio: 1.5,
    startId: start,
    endId: end,
  );

  group('CardLayout', () {
    test('complète la dernière feuille : 20 cartes demandées → 3 pages, 27 cartes', () {
      final l = layout();
      expect(l.cardsPerPage, 9);
      expect(l.pageCount, 3);
      expect(l.endId, 27);
      expect(l.cardCount, 27);
    });

    test('une plage qui tombe juste ne dépasse pas', () {
      final l = layout(end: 18);
      expect(l.pageCount, 2);
      expect(l.endId, 18);
    });

    test('une fin avant le début vaut une seule carte', () {
      final l = layout(start: 10, end: 3);
      expect(l.pageCount, 1);
      expect(l.firstIdOfPage(0), 10);
    });

    test('la hauteur suit le ratio de l\'image, en points', () {
      final l = layout();
      expect(l.cardWidth, closeTo(60 * 72 / 25.4, 1e-9));
      expect(l.cardHeight, closeTo(90 * 72 / 25.4, 1e-9));
    });

    test('portrait et paysage échangent largeur et hauteur de page', () {
      expect(layout().pageWidth, closeTo(CardLayout.mm(210), 1e-9));
      expect(layout(settings: const CardSettings(landscape: true)).pageWidth, closeTo(CardLayout.mm(297), 1e-9));
    });

    test('la grille est centrée dans la page moins sa marge', () {
      final l = layout(settings: const CardSettings(cardWidth: 60, cardsPerRow: 3, rowsPerPage: 3, landscape: false, gapX: 5, pageMargin: 10));
      // 3 × 60 + 2 × 5 = 190 mm de grille dans 210 − 20 = 190 mm utiles : collée à la marge.
      expect(l.gridWidth, closeTo(CardLayout.mm(190), 1e-9));
      expect(l.gridLeft, closeTo(CardLayout.mm(10), 1e-9));
      expect(l.cardOffset(1).left, closeTo(CardLayout.mm(10 + 60 + 5), 1e-9));
      expect(l.cardOffset(3).top, closeTo(l.gridTop + l.cardHeight, 1e-9));
    });
  });

  group('CardSettings.fromEvent', () {
    test('un événement jamais réglé prend les défauts', () {
      final s = CardSettings.fromEvent(Event());
      expect(s.cardWidth, 60.0);
      expect(s.qrCodeSize, 30.0);
      expect(s.cardsPerRow, 4);
      expect(s.idBackgroundColor, isNull);
    });

    test('une valeur nulle d\'Isar (négative) sur un ancien enregistrement prend le défaut', () {
      final event = Event()
        ..playerCardsPerRow = -9223372036854775808
        ..playerCardGapX = -1
        ..idBackgroundColor = -9223372036854775808
        ..qrCodeSize = double.nan;
      final s = CardSettings.fromEvent(event);
      expect(s.cardsPerRow, 4);
      expect(s.gapX, 0.0);
      expect(s.idBackgroundColor, isNull);
      expect(s.qrCodeSize, 30.0);
    });

    test('applyTo puis fromEvent rend les mêmes réglages', () {
      const s = CardSettings(cardWidth: 85.5, cardsPerRow: 2, rowsPerPage: 5, landscape: false, gapX: 3, gapY: 4.2,
        pageMargin: 7, pageBackgroundColor: 0xFFEEEEEE, qrCodeSize: 25, qrCodePosX: 5, qrCodePosY: 6,
        qrCodePadding: 2, qrCodeBackgroundColor: 0xFFFFFFFF, idPosX: 1.5, idPosY: 2, idFontSize: 14,
        idColor: 0xFF112233, idPadding: 1, idBackgroundColor: 0xFF445566);
      final event = Event();
      s.applyTo(event);
      expect(CardSettings.fromEvent(event), s);
    });
  });

  group('Event.qrCodeFor / saltFromCode', () {
    test('sans protection, le numéro seul', () {
      expect(Event().qrCodeFor(12), '12');
      expect(Event.saltFromCode('12'), '');
    });

    test('avec protection, sel-numéro, et le sel se retrouve même s\'il contient un « - »', () {
      final event = Event()..qrSalt = 'ab-12cd';
      expect(event.qrCodeFor(7), 'ab-12cd-7');
      expect(Event.saltFromCode('ab-12cd-7'), 'ab-12cd');
    });
  });
}
