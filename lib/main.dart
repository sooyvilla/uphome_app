import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/environment_config.dart';
import 'core/di/injection.dart';
import 'core/enums/environment.dart';
import 'ui/app.dart';

void main() async {
  EnvironmentConfig.setEnvironment(Environment.local);

  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(databaseProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
