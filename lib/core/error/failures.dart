part of core;

abstract class Failure {}

class CacheFailure extends Failure {}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure(this.message);

  @override
  String toString() {
    return message.toString();
  }
}
