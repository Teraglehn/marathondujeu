import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'card_settings.freezed.dart';

/// Les réglages de mise en page des cartes d'un événement, tels que l'écran les édite.
/// Longueurs en mm (décimales), couleurs en ARGB ; un fond `null` = pas de fond.
/// Copie de travail des champs de [Event] : `fromEvent` les lit, `applyTo` les écrit.
@freezed
abstract class CardSettings with _$CardSettings {
  const CardSettings._();

  const factory CardSettings({
    @Default(60.0) double cardWidth,
    @Default(4) int cardsPerRow,
    @Default(2) int rowsPerPage,
    @Default(true) bool landscape,
    @Default(0.0) double gapX,
    @Default(0.0) double gapY,
    @Default(0.0) double pageMargin,
    @Default(0xFFFFFFFF) int pageBackgroundColor,
    @Default(30.0) double qrCodeSize,
    @Default(0.0) double qrCodePosX,
    @Default(0.0) double qrCodePosY,
    @Default(0.0) double qrCodePadding,
    int? qrCodeBackgroundColor,
    @Default(0.0) double idPosX,
    @Default(0.0) double idPosY,
    @Default(12) int idFontSize,
    @Default(0xFF000000) int idColor,
    @Default(0.0) double idPadding,
    int? idBackgroundColor,
  }) = _CardSettings;

  /// Un champ jamais alimenté vaut 0 (ancien schéma), moins que 0 (valeur nulle d'Isar) ou NaN :
  /// on prend alors la valeur par défaut.
  static int _or(int value, int fallback) => value <= 0 ? fallback : value;
  static double _orMm(double value, double fallback) => value.isNaN || value <= 0 ? fallback : value;
  static double _orZero(double value) => value.isNaN || value < 0 ? 0 : value;
  static int? _orNull(int? value) => value == null || value < 0 ? null : value;

  factory CardSettings.fromEvent(Event event) {
    const defaults = CardSettings();
    return CardSettings(
      cardWidth: _orMm(event.playerCardWidth, defaults.cardWidth),
      cardsPerRow: _or(event.playerCardsPerRow, defaults.cardsPerRow),
      rowsPerPage: _or(event.playerCardRowsPerPage, defaults.rowsPerPage),
      landscape: event.playerCardLandscape,
      gapX: _orZero(event.playerCardGapX),
      gapY: _orZero(event.playerCardGapY),
      pageMargin: _orZero(event.pageMargin),
      pageBackgroundColor: _or(event.pageBackgroundColor, defaults.pageBackgroundColor),
      qrCodeSize: _orMm(event.qrCodeSize, defaults.qrCodeSize),
      qrCodePosX: _orZero(event.qrCodePosX),
      qrCodePosY: _orZero(event.qrCodePosY),
      qrCodePadding: _orZero(event.qrCodePadding),
      qrCodeBackgroundColor: _orNull(event.qrCodeBackgroundColor),
      idPosX: _orZero(event.idPosX),
      idPosY: _orZero(event.idPosY),
      idFontSize: _or(event.idFontSize, defaults.idFontSize),
      idColor: _or(event.idColor, defaults.idColor),
      idPadding: _orZero(event.idPadding),
      idBackgroundColor: _orNull(event.idBackgroundColor),
    );
  }

  void applyTo(Event event) {
    event
      ..playerCardWidth = cardWidth
      ..playerCardsPerRow = cardsPerRow
      ..playerCardRowsPerPage = rowsPerPage
      ..playerCardLandscape = landscape
      ..playerCardGapX = gapX
      ..playerCardGapY = gapY
      ..pageMargin = pageMargin
      ..pageBackgroundColor = pageBackgroundColor
      ..qrCodeSize = qrCodeSize
      ..qrCodePosX = qrCodePosX
      ..qrCodePosY = qrCodePosY
      ..qrCodePadding = qrCodePadding
      ..qrCodeBackgroundColor = qrCodeBackgroundColor
      ..idPosX = idPosX
      ..idPosY = idPosY
      ..idFontSize = idFontSize
      ..idColor = idColor
      ..idPadding = idPadding
      ..idBackgroundColor = idBackgroundColor;
  }
}
