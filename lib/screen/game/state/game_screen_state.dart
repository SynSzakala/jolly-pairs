import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jolly_pairs/screen/game/state/game_data.dart';
import 'package:jolly_pairs/util/extension/list_extensions.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class GameScreenSectionState {
  final List<String> phrases;
  final Set<String> revealedPhrases;
  final void Function(String) onPhrasePressed;

  const GameScreenSectionState({
    required this.phrases,
    required this.revealedPhrases,
    required this.onPhrasePressed,
  });
}

class GameScreenState {
  final GameScreenSectionState leftState, rightState;

  const GameScreenState({required this.leftState, required this.rightState});
}

GameScreenState useGameScreenState({required Future<void> Function() showSuccessDialog}) {
  final resetSignal = useState(0);
  final phrases = useMemoized(GameData.getRandomPhrases, [resetSignal.value]);
  final leftPhrases = useMemoized(phrases.shuffled, [resetSignal.value]);
  final rightPhrases = useMemoized(phrases.shuffled, [resetSignal.value]);

  final permanentlyRevealedPhrases = useState(<String>{});
  final leftRevealedPhrase = useState<String?>(null);
  final rightRevealedPhrase = useState<String?>(null);

  Future<void> afterMatchingPhrasesRevealed() async {
    permanentlyRevealedPhrases.mutate((it) => it.add(leftRevealedPhrase.value!));
    leftRevealedPhrase.value = rightRevealedPhrase.value = null;

    if (permanentlyRevealedPhrases.value.length == GameData.cardCount) {
      await showSuccessDialog();
      permanentlyRevealedPhrases.value = {};
      await Future<void>.delayed(const Duration(seconds: 2)); // wait for cards to hide before setting new phrases
      resetSignal.value++;
    }
  }

  Future<void> afterNonMatchingPhrasesRevealed() async {
    await Future<void>.delayed(GameData.nonMatchingDuration);
    leftRevealedPhrase.value = rightRevealedPhrase.value = null;
  }

  void afterPhraseRevealed() {
    if (leftRevealedPhrase.value == null || rightRevealedPhrase.value == null) return; // only one phrase is revealed
    if (leftRevealedPhrase.value == rightRevealedPhrase.value) {
      unawaited(afterMatchingPhrasesRevealed());
    } else {
      unawaited(afterNonMatchingPhrasesRevealed());
    }
  }

  GameScreenSectionState buildSectionState(List<String> phrases, ValueNotifier<String?> revealedPhrase) {
    return GameScreenSectionState(
      phrases: phrases,
      revealedPhrases: {...permanentlyRevealedPhrases.value, if (revealedPhrase.value != null) revealedPhrase.value!},
      onPhrasePressed: (phrase) {
        if (revealedPhrase.value != null) return; // already revealed
        revealedPhrase.value = phrase;
        afterPhraseRevealed();
      },
    );
  }

  return GameScreenState(
    leftState: buildSectionState(leftPhrases, leftRevealedPhrase),
    rightState: buildSectionState(rightPhrases, rightRevealedPhrase),
  );
}
