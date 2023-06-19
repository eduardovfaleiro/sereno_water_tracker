part of core;

abstract interface class Failure {
  final String? message;

  Failure(this.message);
}

class CacheFailure implements Failure {
  @override
  final String? message;

  CacheFailure([this.message]);
}

class GetItFailure implements Failure {
  @override
  final String? message;

  GetItFailure([this.message]);
}

class AlreadyLastStageFailure implements Failure {
  @override
  final String? message;

  AlreadyLastStageFailure([this.message]);
}

class AlreadyFirstStageFailure implements Failure {
  @override
  final String? message;

  AlreadyFirstStageFailure([this.message]);
}
