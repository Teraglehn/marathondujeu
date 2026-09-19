import 'package:flutter_test/flutter_test.dart';
import 'package:marathondujeu/src/data/data.dart';

void main() {
  group('égalité par id', () {
    test('Event : même id persisté → égaux', () {
      expect(Event()..id = 1, equals(Event()..id = 1));
      expect(Event()..id = 1, isNot(equals(Event()..id = 2)));
    });

    test('Draw : même id persisté → égaux', () {
      expect(Draw()..id = 1, equals(Draw()..id = 1));
      expect(Draw()..id = 1, isNot(equals(Draw()..id = 2)));
    });

    test('DrawWinner : même id persisté → égaux', () {
      expect(DrawWinner()..id = 1, equals(DrawWinner()..id = 1));
      expect(DrawWinner()..id = 1, isNot(equals(DrawWinner()..id = 2)));
    });

    test('un objet non persisté n\'est égal qu\'à lui-même', () {
      final a = Event();
      expect(a, equals(a));
      expect(Event(), isNot(equals(Event())));
    });

    test('un type ne se confond pas avec un autre', () {
      expect(Event()..id = 1, isNot(equals(Session()..id = 1)));
      expect(Draw()..id = 1, isNot(equals(Session()..id = 1)));
    });
  });
}
