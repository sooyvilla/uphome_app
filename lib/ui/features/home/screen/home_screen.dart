import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../styles/colors/up_colors.dart';
import '../../../styles/fonts/fonts.dart';
import '../../../widgets/appbar_custom.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/image_builder.dart';
import '../../create/screen/create_screen.dart';
import '../../details/screen/details_screen.dart';
import '../provider/home_privder.dart';

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
      final homeNotifier = ref.read(homeProvider.notifier);
      homeNotifier.getProjects();

      // Escuchar cambios en el estado del FocusNode del provider.
      homeNotifier.focusNode.addListener(() {
        setState(() {
          _hasFocus = homeNotifier.focusNode.hasFocus;
        });
      });
    });
  }

  void _removeFocus() {
    final focusNode = ref.read(homeProvider.notifier).focusNode;
    focusNode.unfocus();
    setState(() {
      _hasFocus = false;
    });
  }

  @override
  void dispose() {
    final focusNode = ref.read(homeProvider.notifier).focusNode;
    focusNode.removeListener(() {});
    super.dispose();
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
                      onPressed: () async {
                        await Navigator.of(context)
                            .pushNamed(CreateScreen.routeName);

                        ref.read(homeProvider.notifier).getProjects();
                      },
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

                    return GestureDetector(
                      onTap: () async {
                        _removeFocus();
                        await Navigator.of(context).pushNamed(
                          DetailsScreen.routeName,
                          arguments: project,
                        );
                        ref.read(themeNotifierProvider.notifier).reset();
                      },
                      child: Container(
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
                            Hero(
                              tag: project.id,
                              child: ImageBuilder(
                                image: project.imageUrl ?? '',
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
