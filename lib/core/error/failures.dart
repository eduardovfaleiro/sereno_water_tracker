part of core;

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return message.toString();
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class IconNotFoundFailure extends Failure {
  IconNotFoundFailure(super.message);
}

class TypeFailure implements Failure {
  final Error error;

  TypeFailure(this.error);

  @override
  String get message => error.toString();
}

class NegativeNumberFailure implements Failure {
  @override
  String get message => 'Número não deve ser negativo';
}

class ReminderNotFoundFailure extends Failure {
  ReminderNotFoundFailure(super.message);
}

class ReminderCountCannotBeZero extends Failure {
  ReminderCountCannotBeZero(super.message);
}

class ReminderAlreadyExistsFailure implements Failure {
  @override
  String get message => 'Lembrete já existe';
}
