import 'package:flutter/material.dart';

import '../../core/exports.dart';
import '../styles/colors/up_colors.dart';
import '../styles/fonts/fonts.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = UpColors.primary,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 28),
      ),
      child: Text(
        text,
        style: Fonts.ROBOTO_16_BOLD,
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text.addButtonText,
              style: Fonts.ROBOTO_20_NORMAL.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          Material(
            color: UpColors.primary,
            borderRadius: BorderRadius.circular(8),
            child: IconButton(
              onPressed: onPressed,
              color: Colors.white,
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
