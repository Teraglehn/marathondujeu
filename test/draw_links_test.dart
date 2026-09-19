import 'package:flutter_test/flutter_test.dart';
import 'package:marathondujeu/src/data/data.dart';

import 'isar_test_support.dart';

void main() {
  /// Un tirage neuf ou copié garde ses choix en mémoire : Isar refuse `toSet` tant qu'il n'est pas en base.
  test('Draw.linked lit un tirage neuf et un tirage en base', () async {
    final isar = await openTestIsar();
    final event = Event()..name = 'e';
    final g = PlayerGroup.empty()..name = 'g'..event.value = event;
    await isar.writeTxn(() async { await isar.events.put(event); await isar.playerGroups.put(g); });
    final draw = Draw.empty()..event.value = event;
    draw.excludedGroups.add(g);
    expect(Draw.linked(draw.excludedGroups), {g});
    expect(Draw.linked(draw.requiredGroups), isEmpty);
    await isar.writeTxn(() async { await isar.draws.put(draw); await draw.excludedGroups.save(); });
    final reloaded = (await isar.draws.get(draw.id))!;
    expect(Draw.linked(reloaded.excludedGroups), {g});
    await isar.close(deleteFromDisk: true);
  });
}
