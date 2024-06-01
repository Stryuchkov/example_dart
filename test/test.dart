
import 'package:example_dart/game.dart';
import 'package:test/test.dart';

void main() {
  group ('value should be',()
  {
    test('wrong data OFFSET', () {
      final game = generateGame();
      final result = getScore(game, (-1));
      expect(result,
          null);
    });
    test('wrong data OFFSET', () {
      final game = generateGame();
      final result = getScore(game, ((game.last.offset) + 1));
      expect(result,  null);
    });

    test
      ('right data OFFSET', () {
final game =  generateGame();
int offset = game.last.offset;
final scoreMain = getScore(game, offset );

expect (scoreMain!, Score (away: scoreMain.away, home: scoreMain.home) ); });
  });
}

