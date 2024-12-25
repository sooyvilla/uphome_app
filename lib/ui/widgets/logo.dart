import 'package:flutter/material.dart';

import '../../core/exports.dart';
import '../styles/colors/up_colors.dart';
import '../styles/fonts/fonts.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: UpColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.home,
            color: Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text.firstHeaderName,
          style: Fonts.ROBOTO_48_BOLD,
        ),
        Text(
          text.lastHeaderName,
          style: Fonts.ROBOTO_48_REGULAR,
        ),
      ],
    );
  }
}
