import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'event.g.dart';

@collection
class Event {
  Id id = Isar.autoIncrement;
  String name ="";

  /// Identifiant stable, qui voyage dans le fichier de sauvegarde (L09) : les `id` Isar sont
  /// propres à chaque base. Posé à la création ; vide pour les événements d'avant, jusqu'à
  /// leur première écriture.
  String uid = "";

  /// Le chemin du fichier de sauvegarde sur ce poste (L09) ; null : pas de fichier. Ne voyage
  /// pas dans le fichier.
  String? backupPath;

  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now().add(const Duration(days: 1));

  int sessionTimeMinutes = 15;
  int sessionIntervalMinutes = 60;


  String qrSalt = "";

  int playerCardHeight = 0;
  double playerCardWidth = 0;

  List<byte>? playerCardBackgroundImage;

  double qrCodeSize = 0;
  double qrCodePosX = 0;
  double qrCodePosY = 0;

  double idPosX = 0;
  double idPosY = 0;

  // Mise en page des cartes (L05). Longueurs en mm (décimales), couleurs en ARGB ; un fond `null` = pas de fond.
  int playerCardsPerRow = 4;
  int playerCardRowsPerPage = 2;
  bool playerCardLandscape = true;
  double playerCardGapX = 0;
  double playerCardGapY = 0;
  double pageMargin = 0;
  int pageBackgroundColor = 0xFFFFFFFF;
  double qrCodePadding = 0;
  int? qrCodeBackgroundColor;
  int idFontSize = 12;
  int idColor = 0xFF000000;
  double idPadding = 0;
  int? idBackgroundColor;
  
  @Backlink(to: 'event')
  final players = IsarLinks<Player>();

  @Backlink(to: 'event')
  final sessions = IsarLinks<Session>();

  Event();

  factory Event.empty() {
    return Event();
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Event) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;

  /// Le code porté par le QR d'une carte : `sel-numéro`, ou le numéro seul sans protection.
  /// Le numéro est toujours après le dernier « - ».
  String qrCodeFor(int number) => qrSalt.isEmpty ? number.toString() : '$qrSalt-$number';

  /// Le sel d'un code scanné : ce qui précède le dernier « - », vide s'il n'y en a pas.
  static String saltFromCode(String code) {
    final i = code.lastIndexOf('-');
    return i < 0 ? '' : code.substring(0, i);
  }
}
