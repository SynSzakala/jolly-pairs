import 'package:flutter/cupertino.dart';
import 'package:jolly_pairs/screen/game/state/game_data.dart';
import 'package:utopia_utils/utopia_utils.dart';

class GameScreenSectionLayout extends StatelessWidget {
  final Widget Function(int index) builder;

  const GameScreenSectionLayout({required this.builder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var row = 0; row < GameData.rows; row++) Expanded(child: _buildRow(row)),
      ].separatedWith(const SizedBox(height: 16)),
    );
  }

  Widget _buildRow(int row) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var column = 0; column < GameData.columns; column++)
          Expanded(child: builder(row * GameData.columns + column)),
      ].separatedWith(const SizedBox(width: 16)),
    );
  }
}
