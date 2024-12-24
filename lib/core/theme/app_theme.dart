import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uphome_app/ui/styles/colors/up_colors.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, Color>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<Color> {
  ThemeNotifier() : super(UpColors.primary);

  void updateTheme(Color color) {
    state = color;
  }
}

class AppTheme {
  final Color color;

  AppTheme(this.color);

  ThemeData get theme => ThemeData(colorSchemeSeed: color);
}
