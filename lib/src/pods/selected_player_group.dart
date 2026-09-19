
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_player_group.g.dart';

@riverpod
class SelectedPlayerGroup extends _$SelectedPlayerGroup {
  PlayerGroupService get _service => ref.watch(playerGroupServiceProvider);

  @override
  Stream<PlayerGroup?> build() async* {
    final main = ref.watch(mainPodProvider);
    if(main.selectedPlayerGroupId == null){
      yield null;
    }
    yield* await _service.getByIdStream(main.selectedPlayerGroupId!);
  }

  // Deux lectures du même groupe sont « égales » (comparaison par identifiant) : sans ceci,
  // Riverpod ne préviendrait pas la page quand la base change — un membre retiré resterait affiché.
  @override
  bool updateShouldNotify(AsyncValue<PlayerGroup?> previous, AsyncValue<PlayerGroup?> next) => true;

  Future<void> save(PlayerGroup item) {
    return _service.save(item);
  }

  Future<void> delete(PlayerGroup item) {
    return _service.delete(item);
  }
}