import 'package:flutter_test/flutter_test.dart';
import 'package:marathondujeu/src/data/data.dart';

/// L18 : la logique de SE-1 — une session est ouverte entre son début et sa fin, bornes exclues.
void main() {
  final session = Session()
    ..number = 1
    ..startTime = DateTime(2026, 10, 3, 11)
    ..endTime = DateTime(2026, 10, 3, 11, 15);

  test('ouverte pendant, fermée avant, après et sur les bornes', () {
    expect(session.isOpenAt(DateTime(2026, 10, 3, 11, 5)), isTrue);
    expect(session.isOpenAt(DateTime(2026, 10, 3, 10, 59)), isFalse);
    expect(session.isOpenAt(DateTime(2026, 10, 3, 11, 16)), isFalse);
    expect(session.isOpenAt(DateTime(2026, 10, 3, 11)), isFalse);
    expect(session.isOpenAt(DateTime(2026, 10, 3, 11, 15)), isFalse);
  });
}
