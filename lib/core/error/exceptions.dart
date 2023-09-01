class CacheException implements Exception {}

class ValidationException implements Exception {}

class IconNotFoundException implements Exception {
  final String message;

  IconNotFoundException(this.message);

  @override
  String toString() {
    return message.toString();
  }
}

class WaterContainerNotFoundException implements Exception {}

class LeftException implements Exception {}

class TimeToDrinkAlreadyExists implements Exception {}
