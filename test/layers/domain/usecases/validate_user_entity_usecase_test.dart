import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/entities/user_entity.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/validate_user_entity_usecase.dart';

void main() {
  late ValidateUserEntityUseCase useCase;

  setUp(() {
    useCase = ValidateUserEntityUseCaseImp();
  });

  test('Should return false when either wakeUpTime or sleepTime are null', () async {
    var userEntity = UserEntity();

    var result = useCase(userEntity);
    var expectedResult = result.fold((failure) => failure, (_) {});

    expect(expectedResult, isA<ValidationFailure>());
  });

  test('Should return true when neither wakeUpTime or sleepTime are null', () async {
    var userEntity = UserEntity(
      wakeUpTime: const TimeOfDay(hour: 10, minute: 0),
      sleepTime: const TimeOfDay(hour: 22, minute: 0),
    );

    var result = useCase(userEntity);

    expect(result, const Right(null));
  });
}
