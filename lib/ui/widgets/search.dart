import 'package:flutter/material.dart';
import 'package:uphome_app/core/exports.dart';
import 'package:uphome_app/ui/widgets/buttons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
            size: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: text.searchBarHintText,
                border: InputBorder.none,
              ),
            ),
          ),
          PrimaryTextButton(text: text.buttonText),
        ],
      ),
    );
  }
}
