import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui/styles/colors/up_colors.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme(UpColors.background));

  void updateTheme(Color color) {
    state = AppTheme(color);
  }

  void reset() {
    state = AppTheme(UpColors.background);
  }
}

class AppTheme {
  final Color color;

  AppTheme(this.color);

  ThemeData get theme => ThemeData(
        colorSchemeSeed: color,
        scaffoldBackgroundColor:
            color == UpColors.background ? Colors.white : null,
        appBarTheme: AppBarTheme(
          backgroundColor: color == UpColors.background ? Colors.white : color,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );
}
