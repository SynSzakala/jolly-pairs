import 'package:jolly_pairs/screen/game/game_screen.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    GameScreen.route: GameScreen.routeConfig,
  };

  static const initialRoute = GameScreen.route;
}
