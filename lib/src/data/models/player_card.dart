import 'dart:typed_data';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

part 'player_card.freezed.dart';

@freezed
class PlayerCard with _$PlayerCard{
  const PlayerCard._();

  const factory PlayerCard({
    required String code,
  }) = _PlayerCard;

  QrImage getQrImage(){
    return QrImage(QrCode.fromData(data: code, errorCorrectLevel: QrErrorCorrectLevel.L));
  }

  Future<ByteData?> getImageAsByte({
    required int size
  }){
    return getQrImage().toImageAsBytes(size: size);
  }
}