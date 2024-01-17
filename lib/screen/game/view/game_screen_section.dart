import 'package:flutter/cupertino.dart';
import 'package:jolly_pairs/screen/game/state/game_screen_state.dart';
import 'package:jolly_pairs/screen/game/view/game_screen_card.dart';
import 'package:jolly_pairs/screen/game/view/game_screen_section_layout.dart';

class GameScreenSection extends StatelessWidget {
  final GameScreenSectionState state;
  final Color primaryColor;

  const GameScreenSection(this.state, {required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return GameScreenSectionLayout(
      builder: (index) {
        final phrase = state.phrases[index];
        return GameScreenCard(
          phrase: phrase,
          isRevealed: state.revealedPhrases.contains(phrase),
          primaryColor: primaryColor,
          onPressed: () => state.onPhrasePressed(phrase),
        );
      },
    );
  }
}
