import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uphome_app/ui/features/home/provider/home_privder.dart';
import 'package:uphome_app/ui/styles/colors/up_colors.dart';
import 'package:uphome_app/ui/styles/fonts/fonts.dart';

import '../../../widgets/appbar_custom.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).getProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final homeNotifier = ref.watch(homeProvider);

    return Scaffold(
      body: Column(
        children: [
          const AppbarCustom(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, bottom: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            text.addButtonText,
                            style: Fonts.ROBOTO_20_NORMAL.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Material(
                          color: UpColors.primary,
                          borderRadius: BorderRadius.circular(8),
                          child: IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            icon: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeNotifier.projects.length,
                    padding: const EdgeInsets.all(16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final project = homeNotifier.projects[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          color: UpColors.background,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                project.imageUrl ?? '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.name,
                                    style: Fonts.ROBOTO_20_BOLD.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    project.location,
                                    style: Fonts.ROBOTO_16_BOLD.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          items: const [
            DropdownMenuItem(
              value: 'hola',
              child: Text('Hola'),
            ),
            DropdownMenuItem(
              value: 'a',
              child: Text('A'),
            ),
            DropdownMenuItem(
              value: 'e',
              child: Text('E'),
            ),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
