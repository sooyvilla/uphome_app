import 'package:flutter/material.dart';

extension ColorConvert on String {
  Color toColor() {
    final hexColor = replaceAll('#', '').padLeft(8, 'FF');
    return Color(int.parse(hexColor, radix: 16));
  }
}