import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';

import './state/game_screen_state.dart';
import './view/game_screen_view.dart';

class GameScreen extends HookWidget {
  static const route = '/game';
  static final routeConfig = RouteConfig.material(GameScreen._);

  const GameScreen._();

  @override
  Widget build(BuildContext context) {
    final state = useGameScreenState(
      showSuccessDialog: () async => _showSuccessDialog(context),
    );
    return GameScreenView(state: state);
  }

  static Future<void> _showSuccessDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You have won the game!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
