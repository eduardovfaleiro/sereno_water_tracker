abstract class InitialRoute {
  static late String _initialRoute;

  static String get() {
    return _initialRoute;
  }

  static void set(String initialRoute) {
    _initialRoute = initialRoute;
  }
}
