import 'package:isar_community/isar.dart';
// ignore: implementation_imports
import 'package:isar_community/src/common/isar_links_common.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'draw.g.dart';

@collection
class Draw {
  Id id = Isar.autoIncrement;
  late String name;

  /// Le rang du tirage dans son événement (L21) : 1, 2, 3… dans l'ordre de création, jamais
  /// réattribué ; c'est lui que l'écran montre, pas `id`. 0 tant que non attribué (bases d'avant).
  int number = 0;

  int minSessionNumber = 1;
  int maxSessionNumber = 0;
  int winnerCount = 1;

  /// Date du lancement : un tirage ne se lance qu'une fois (L06). Null tant qu'il est préparé.
  DateTime? drawnAt;
  
  final excludedSessions = IsarLinks<Session>();
  final requiredSessions = IsarLinks<Session>();

  /// Groupes choisis à l'écran, résolus en joueurs au moment du tirage.
  final excludedGroups = IsarLinks<PlayerGroup>();
  final requiredGroups = IsarLinks<PlayerGroup>();

  /// Le groupe « Gagnants du tirage … », créé au lancement ; une copie l'exclut.
  final winnersGroup = IsarLink<PlayerGroup>();

  /// Joueurs exclus / requis individuellement (les gagnants d'un tirage copié, par exemple).
  final excludedPlayers = IsarLinks<Player>();
  final requiredPlayers = IsarLinks<Player>();

  @Backlink(to: "draw")
  final winners = IsarLinks<DrawWinner>();

  final event = IsarLink<Event>();

  Draw();

  factory Draw.empty() {
    return Draw()..name ="Tirage";
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Draw) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;

  /// Les objets d'un lien, que le tirage soit en base ou non : un tirage neuf ou copié garde ses
  /// choix en mémoire, où `toSet` et `contains` d'Isar refusent de lire.
  static Set<T> linked<T>(IsarLinks<T> links) =>
    links.isAttached ? links.toSet() : (links as IsarLinksCommon<T>).addedObjects.toSet();

  /// Effectué : daté, ou — tirages d'avant la date — ayant des gagnants.
  @ignore
  bool get isDrawn => drawnAt != null || winners.isNotEmpty;
}
