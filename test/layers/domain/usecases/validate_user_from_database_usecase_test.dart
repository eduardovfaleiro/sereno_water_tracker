import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/validate_user_entity_usecase.dart';

abstract interface class ValidateUserFromDataBaseUseCase {
  Future<bool> call();
}

class ValidateUserFromDataBaseUseCaseImp implements ValidateUserFromDataBaseUseCase {
  final ValidateUserEntityUseCase _validateUserEntityUseCase;
  final UserRepository _userRepository;

  ValidateUserFromDataBaseUseCaseImp(this._userRepository, this._validateUserEntityUseCase);

  @override
  Future<bool> call() {
    throw UnimplementedError();
  }
}

void main() {
  test('Should return true if user from database if valid', () async {
    // arrange

    // act

    // assert
  });
}
