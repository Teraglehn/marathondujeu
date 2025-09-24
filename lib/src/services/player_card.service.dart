import 'package:marathondujeu/src/data/data.dart';

abstract class PlayerCardService {

  static PlayerCard getCardFromPlayer(Player player){
    return PlayerCard(code: player.qrcode);
  }

  static List<PlayerCard> getCardsFromPlayers(List<Player> players){
    return players.map(getCardFromPlayer).toList();
  }

}