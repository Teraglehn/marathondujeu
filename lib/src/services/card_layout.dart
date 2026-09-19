import 'package:marathondujeu/src/data/models/card_settings.dart';

/// La mise en page d'une planche de cartes, calculée sans PDF : tout en points PDF (1/72 pouce).
/// Entrées : les réglages en mm, le ratio de l'image (hauteur / largeur), la plage de numéros.
class CardLayout {
  static const double mmToPt = 72 / 25.4;
  static const double a4WidthMm = 210;
  static const double a4HeightMm = 297;

  final CardSettings settings;
  final double imageRatio;
  final int startId;
  final int requestedEndId;

  CardLayout({required this.settings, required this.imageRatio, required this.startId, required int endId})
    : requestedEndId = endId < startId ? startId : endId;

  static double mm(num value) => value * mmToPt;

  double get pageWidth => mm(settings.landscape ? a4HeightMm : a4WidthMm);
  double get pageHeight => mm(settings.landscape ? a4WidthMm : a4HeightMm);

  double get cardWidth => mm(settings.cardWidth);
  double get cardHeight => cardWidth * imageRatio;

  int get cardsPerPage => settings.cardsPerRow * settings.rowsPerPage;

  /// Le nombre de pages couvre la plage demandée.
  int get pageCount => ((requestedEndId - startId + 1) / cardsPerPage).ceil();

  /// La dernière feuille est complétée : le dernier numéro imprimé peut dépasser celui demandé.
  int get endId => startId + pageCount * cardsPerPage - 1;

  int get cardCount => endId - startId + 1;

  double get gridWidth => settings.cardsPerRow * cardWidth + (settings.cardsPerRow - 1) * mm(settings.gapX);
  double get gridHeight => settings.rowsPerPage * cardHeight + (settings.rowsPerPage - 1) * mm(settings.gapY);

  /// La grille est centrée dans la page moins sa marge.
  double get gridLeft => mm(settings.pageMargin) + (pageWidth - 2 * mm(settings.pageMargin) - gridWidth) / 2;
  double get gridTop => mm(settings.pageMargin) + (pageHeight - 2 * mm(settings.pageMargin) - gridHeight) / 2;

  /// Le premier numéro de la page [page] (à partir de 0).
  int firstIdOfPage(int page) => startId + page * cardsPerPage;

  /// Position (gauche, haut) de la carte [index] (0 à cardsPerPage − 1) sur sa page.
  ({double left, double top}) cardOffset(int index) {
    final column = index % settings.cardsPerRow;
    final row = index ~/ settings.cardsPerRow;
    return (
      left: gridLeft + column * (cardWidth + mm(settings.gapX)),
      top: gridTop + row * (cardHeight + mm(settings.gapY)),
    );
  }
}
