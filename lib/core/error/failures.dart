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
