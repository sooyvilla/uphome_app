import 'package:flutter/material.dart';

import '../../core/exports.dart';

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          hint: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(text.filter),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
