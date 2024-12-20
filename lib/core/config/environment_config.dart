import '../enums/environment.dart';

class EnvironmentConfig {
  static Environment _environment = Environment.mock;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static Environment get current => _environment;
}
