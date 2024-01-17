import 'package:flutter/material.dart';
import 'package:jolly_pairs/screen/game/view/game_screen_section.dart';
import 'package:utopia_utils/utopia_utils.dart';

import '../state/game_screen_state.dart';

class GameScreenView extends StatelessWidget {
  final GameScreenState state;

  const GameScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: <Widget>[
            Expanded(child: GameScreenSection(state.leftState, primaryColor: Colors.teal)),
            Expanded(child: GameScreenSection(state.rightState, primaryColor: Colors.tealAccent)),
          ].separatedWith(const SizedBox(width: 16))
        ),
      ),
    );
  }
}
