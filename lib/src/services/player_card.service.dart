import 'package:marathondujeu/src/data/data.dart';
import 'package:uuid/uuid.dart';

abstract class PlayerCardService {

  static PlayerCard getCardFromPlayer(Player player){
    return PlayerCard(code: player.qrcode);
  }

  static PlayerCard generatePlayerCard(){
    return PlayerCard(code: Uuid().v4());
  }

}