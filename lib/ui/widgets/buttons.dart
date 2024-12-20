import 'package:flutter/material.dart';
import 'package:uphome_app/ui/styles/colors/up_colors.dart';

import '../styles/fonts/fonts.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: UpColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 28),
      ),
      child: Text(
        text,
        style: Fonts.ROBOTO_16_BOLD,
      ),
    );
  }
}
