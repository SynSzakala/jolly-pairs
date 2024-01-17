import 'package:flutter/widgets.dart';
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
    final state = useGameScreenState();
    return GameScreenView(state: state);
  }
}
