import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uphome_app/ui/features/home/provider/home_privder.dart';
import 'package:uphome_app/ui/styles/colors/up_colors.dart';
import 'package:uphome_app/ui/styles/fonts/fonts.dart';

import '../../../widgets/appbar_custom.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/image_builder.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).getProjects();
      FocusScope.of(context).addListener(() {
        setState(() {
          _hasFocus = FocusScope.of(context).hasFocus;
        });
      });
    });
  }

  void _removeFocus() {
    FocusScope.of(context).unfocus();
    setState(() {
      _hasFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = ref.watch(homeProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: _removeFocus,
        child: Column(
          children: [
            const AppbarCustom(),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
              child: _hasFocus
                  ? const SizedBox.shrink()
                  : ButtonWithText(
                      key: const ValueKey('button'),
                      onPressed: () {},
                    ),
            ),
            if (homeNotifier.status == HomeStatus.loading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (homeNotifier.status == HomeStatus.success)
              Expanded(
                child: ListView.builder(
                  itemCount: homeNotifier.projects.length,
                  padding: const EdgeInsets.all(16),
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
                          ImageWidget(image: project.imageUrl ?? ''),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
