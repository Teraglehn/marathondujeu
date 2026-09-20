import 'package:marathondujeu/src/data/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_status_pod.g.dart';

/// Le résultat du dernier scan, affiché dans la barre du haut de chaque page. Il reste
/// jusqu'au scan suivant, y compris en changeant de page ; `null` tant que rien n'a été scanné.
@Riverpod(keepAlive: true)
class ScanStatusPod extends _$ScanStatusPod {
  @override
  ScanResult? build() => null;

  void set(ScanResult result) => state = result;

  /// Retour au message d'attente — quand ce qu'un scan fait vient de changer.
  void clear() => state = null;
}
