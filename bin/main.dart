
import 'package:example_dart/game.dart';

void main() {
  final game = generateGame();

  game.forEach((e) {print("offset - ${e.offset}; away - ${e.score.away}; home - ${e.score.home};");
  });

  getScore(game, 134664);

}
