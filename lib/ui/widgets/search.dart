import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exports.dart';
import '../features/home/provider/home_privder.dart';
import 'buttons.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
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
              focusNode: ref.read(homeProvider.notifier).focusNode,
              decoration: InputDecoration(
                hintText: text.searchBarHintText,
                border: InputBorder.none,
              ),
              onChanged: (string) {
                ref.read(homeProvider.notifier).setQuery(string);
                if (string.isEmpty) {
                  ref.read(homeProvider.notifier).getProjects();
                }
              },
            ),
          ),
          PrimaryTextButton(
            text: text.buttonText,
            onPressed: () {
              ref.read(homeProvider.notifier).focusNode.unfocus();
              final query = ref.read(homeProvider).query;
              ref.read(homeProvider.notifier).getProjects(query);
            },
          ),
        ],
      ),
    );
  }
}
