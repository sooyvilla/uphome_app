import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import 'features/home/screen/home_screen.dart';
import 'routes/app_routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeColor = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'UpHome',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: themeColor.theme,
      debugShowCheckedModeBanner: true,
      routes: AppRoutes().routes,
      home: const HomeScreen(),
    );
  }
}
