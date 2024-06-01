import 'dart:math';

const TIMESTAMPS_COUNT = 50000;
const PROBABILITY_SCORE_CHANGED = 0.0001;
const PROBABILITY_HOME_SCORE = 0.45;
const OFFSET_MAX_STEP = 3;

class Score {
  final int home;
  final int away;

  Score({
    required this.home,
    required this.away
  });
}

class Stamp {
  final int offset;
  final Score score;

  Stamp({
    required this.offset,
    required this.score
  });
}

final Stamp emptyScoreStamp = Stamp(
  offset: 0,
  score: Score(
    home: 0,
    away: 0,
  ),
);

List<Stamp> generateGame() {
  final stamps = List<Stamp>
      .generate(TIMESTAMPS_COUNT, (score) => emptyScoreStamp);

  var currentStamp = stamps[0];

  for (var i = 0; i < TIMESTAMPS_COUNT; i++) {
    currentStamp = generateStamp(currentStamp);
    stamps[i] = currentStamp;
  }
  return stamps;
}

Stamp generateStamp(Stamp prev) {
  final scoreChanged = Random().nextDouble() > 1 - PROBABILITY_SCORE_CHANGED;
  final homeScoreChange = scoreChanged && Random().nextDouble() < PROBABILITY_HOME_SCORE
      ? 1
      : 0;

  final awayScoreChange = scoreChanged && !(homeScoreChange > 0) ? 1 : 0;
  final offsetChange = (Random().nextDouble() * OFFSET_MAX_STEP).floor() + 1;

  return Stamp(
    offset: prev.offset + offsetChange,
    score: Score(
        home: prev.score.home + homeScoreChange,
        away: prev.score.away + awayScoreChange
    ),
  );
}

Score? getScore(List<Stamp> gameStamps, int offset) {
  int low = 0;
  int hight = (gameStamps.length) -1;
  int midl = (low + hight) ~/ 2;

  try {
    while (offset != gameStamps[midl].offset && low < hight) {
      if (offset > gameStamps[midl].offset) {
        low = midl + 1;
      } else {
        hight = midl - 1;
      }
      midl = (low + hight) ~/ 2;}


    if (offset == gameStamps[midl].offset) {
      Score scoreMain = gameStamps[midl].score;
      int home = scoreMain.home;
      int away = scoreMain.away;
      print('SCORE of the OFFSET ($offset)>  home:$home , away $away');
      return Score (home: home, away: away);
    }
    else if (offset < gameStamps[midl].offset) {
      print('the OFFSET is less than the minimum value: ${gameStamps[low].offset}.');
    }

    else if (offset > gameStamps[midl].offset) {
      print('the OFFSET is more than the maximum value: ${gameStamps[low].offset}');
    }

    else {
      print('Have not this offset!');
    }
    // return gameStamps[midl].score;

  }

  catch (error) {
    print('error');
  }
  return null;

}