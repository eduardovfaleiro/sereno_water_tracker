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

class WaterContainerNotFoundException implements Exception {
  final String message;

  WaterContainerNotFoundException(this.message);

  @override
  String toString() {
    return message.toString();
  }
}

class LeftException implements Exception {}
