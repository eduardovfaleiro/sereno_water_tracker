part of core;

abstract class Failure {
  final String message;

  Failure(this.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}
