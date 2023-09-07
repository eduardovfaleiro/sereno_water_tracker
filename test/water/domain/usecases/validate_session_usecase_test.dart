// ignore_for_file: unnecessary_null_comparison

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/user_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_data_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/validate_session_usecase.dart';

import 'calculate_water_data_usecase_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final mockUserRepository = MockUserRepository();
  final mockWaterRepository = MockWaterRepository();
  final useCase = ValidateSessionUseCaseImp(mockUserRepository, mockWaterRepository);

  test('Should return nothing when validation passes', () async {
    // arrange
    final userEntity = UserEntity.defaultValues();
    final waterDataEntity = WaterDataEntity.empty();

    // arrange
    when(() => mockUserRepository.getUser()).thenAnswer((_) async => Right(userEntity));
    when(() => mockWaterRepository.getWaterData()).thenAnswer((_) async => Right(waterDataEntity));
    when(() => mockWaterRepository.getDailyDrinkingFrequency()).thenAnswer((_) async => const Right(6));

    // act
    final result = await getResult(useCase());

    // assert
    verify(() => mockUserRepository.getUser());
    verify(() => mockWaterRepository.getWaterData());

    expect(result, isA<void>());
  });

  test('Should return ValidationFailure', () async {
    final waterDataEntity = WaterDataEntity.empty();

    // arrange
    when(() => mockUserRepository.getUser()).thenAnswer((_) async => Left(ValidationFailure('')));
    when(() => mockWaterRepository.getWaterData()).thenAnswer((_) async => Right(waterDataEntity));
    when(() => mockWaterRepository.getDailyDrinkingFrequency()).thenAnswer((_) async => const Right(0));

    // act
    final expectedResult = await getResult(useCase());

    // assert
    verify(() => mockUserRepository.getUser());

    expect(expectedResult, isA<ValidationFailure>());
  });
}
