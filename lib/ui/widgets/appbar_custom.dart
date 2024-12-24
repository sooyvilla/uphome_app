import 'package:flutter/material.dart';

import '../../core/exports.dart';
import '../styles/fonts/fonts.dart';
import 'drop_down.dart';
import 'logo.dart';
import 'search.dart';

class AppbarCustom extends StatelessWidget {
  const AppbarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/home_background.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DropDownCustom(),
                const SizedBox(height: 32),
                const LogoWidget(),
                const SizedBox(height: 14),
                Text(
                  text.title,
                  style: Fonts.ROBOTO_42_BOLD,
                ),
                Text(
                  text.subTitle,
                  style: Fonts.ROBOTO_16_NORMAL,
                ),
                const SizedBox(height: 14),
                const SearchWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
