import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uphome_app/ui/features/home/screen/home_screen.dart';
import 'package:uphome_app/ui/routes/app_routes.dart';

import '../core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeColor = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'UpHome',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme(themeColor).theme,
      debugShowCheckedModeBanner: true,
      routes: AppRoutes().routes,
      home: const HomeScreen(),
    );
  }
}
