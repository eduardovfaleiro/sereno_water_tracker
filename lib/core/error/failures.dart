part of core;

abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return message;
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class GetItFailure extends Failure {
  GetItFailure(super.message);
}
