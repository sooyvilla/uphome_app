import 'package:flutter/material.dart';

import '../../domain/entities/project.dart';
import '../features/details/screen/details_screen.dart';
import '../features/home/screen/home_screen.dart';

class AppRoutes {
  final routes = {
    HomeScreen.routeName: (context) => const HomeScreen(),
    DetailsScreen.routeName: (context) => navigateDetailsScreen(context),
  };

  static Widget navigateDetailsScreen(context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    return DetailsScreen(project: args as Project);
  }
}
