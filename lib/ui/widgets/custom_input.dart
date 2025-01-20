import 'package:flutter/material.dart';

import '../styles/colors/up_colors.dart';
import '../styles/fonts/fonts.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;

  const CustomInput({
    Key? key,
    required this.label,
    this.placeholder = '',
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text
        Text(
          label.toUpperCase(),
          style: Fonts.ROBOTO_16_NORMAL.copyWith(color: Colors.black45),
        ),
        const SizedBox(height: 4),
        // Input field
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: Fonts.ROBOTO_14_REGULAR.copyWith(
              color: UpColors.greyBold,
            ),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none, // No border
          ),
        ),
      ],
    );
  }
}
