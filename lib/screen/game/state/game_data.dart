import 'package:jolly_pairs/util/extension/list_extensions.dart';

class GameData {
  const GameData._();

  static const columns = 2;
  static const rows = 3;
  static const cardCount = columns * rows;

  static const nonMatchingDuration = Duration(seconds: 2);

  static const phrases = [
    "dog",
    "cat",
    "mouse",
    "horse",
    "cow",
    "pig",
    "chicken",
    "sheep",
  ];

  static List<String> getRandomPhrases() => phrases.shuffled().take(cardCount).toList();
}
