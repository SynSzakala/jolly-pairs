import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GameScreenCard extends StatelessWidget {
  static const _animationDuration = Duration(milliseconds: 300);

  final String phrase;
  final bool isRevealed;
  final Color primaryColor;
  final void Function() onPressed;

  const GameScreenCard({
    required this.phrase,
    required this.isRevealed,
    required this.primaryColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        decoration: _buildDecoration(),
        child: AnimatedOpacity(
          duration: _animationDuration,
          opacity: isRevealed ? 1 : 0,
          child: _buildText(),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: isRevealed ? Colors.white : primaryColor,
      border: Border.all(
        color: primaryColor,
        width: isRevealed ? 5 : 0,
      ),
    );
  }

  Widget _buildText() {
    return AutoSizeText(
      phrase,
      maxLines: 1,
      style: const TextStyle(fontFamily: 'Salsa', fontSize: 100),
    );
  }
}
