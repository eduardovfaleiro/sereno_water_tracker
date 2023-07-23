import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/user_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/calculate_daily_drinking_goal_usecase.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/validators/validate_user_entity_usecase.dart';
import 'package:sereno_clean_architecture_solid/water/presentation/view_models/save_user_view_model.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockValidateUserEntityUseCase extends Mock implements ValidateUserEntityUseCase {}

class MockCalculateDailyDrinkingGoalUseCase extends Mock implements CalculateDailyDrinkingGoalUseCase {}

void main() {
  late MockValidateUserEntityUseCase mockValidateUserEntityUseCase;
  late MockUserRepository mockUserRepository;
  late MockCalculateDailyDrinkingGoalUseCase mockCalculateDailyDrinkingGoalUseCase;
  late SaveUserViewModel viewModel;

  setUp(() {
    mockValidateUserEntityUseCase = MockValidateUserEntityUseCase();
    mockUserRepository = MockUserRepository();
    mockCalculateDailyDrinkingGoalUseCase = MockCalculateDailyDrinkingGoalUseCase();

    viewModel = SaveUserViewModelImp(
      mockUserRepository,
      mockValidateUserEntityUseCase,
      mockCalculateDailyDrinkingGoalUseCase,
    );

    registerFallbackValue(const TimeOfDay(hour: 0, minute: 0));
    registerFallbackValue(UserEntity());
  });

  group('updateWeight', () {
    int weight = 75;

    test('Should update the user\'s weight', () async {
      // arrange
      when(() => mockUserRepository.updateWeight(weight)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWeight(weight);

      // assert
      verify(() => mockUserRepository.updateWeight(weight));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWeight(weight)).thenAnswer((invocation) async => Left(CacheFailure("Couldn't update weight")));

      // act
      var result = await viewModel.updateWeight(weight);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWeight(weight));
      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('updateWeeklyWorkoutDays', () {
    int weeklyWorkoutDays = 5;

    test('Should update the user\'s weekly workout days', () async {
      // arrange
      when(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWeeklyWorkoutDays(weeklyWorkoutDays);

      // assert
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays)).thenAnswer((invocation) async => Left(CacheFailure("Couldn't update weekly workout days")));

      // act
      var result = await viewModel.updateWeeklyWorkoutDays(weeklyWorkoutDays);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays));
      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('updateWakeUpTime', () {
    var wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should update the user\'s wake up time', () async {
      // arrange
      when(() => mockUserRepository.updateWakeUpTime(wakeUpTime)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWakeUpTime(wakeUpTime);

      // assert
      verify(() => mockUserRepository.updateWakeUpTime(wakeUpTime));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWakeUpTime(wakeUpTime)).thenAnswer((invocation) async => Left(CacheFailure("Couldn't update wake up time")));

      // act
      var result = await viewModel.updateWakeUpTime(wakeUpTime);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWakeUpTime(wakeUpTime));
      expect(expectedResult, isA<CacheFailure>());
    });

    group('updateSleepTime', () {
      var sleepTime = const TimeOfDay(hour: 10, minute: 0);

      test('Should update the user\'s sleeptime', () async {
        // arrange
        when(() => mockUserRepository.updateSleepTime(sleepTime)).thenAnswer((invocation) async => const Right(null));

        // act
        var result = await viewModel.updateSleepTime(sleepTime);

        // assert
        verify(() => mockUserRepository.updateSleepTime(sleepTime));
        expect(result, const Right(null));
      });

      test('Should return CacheFailure when call fails', () async {
        // arrange
        when(() => mockUserRepository.updateSleepTime(sleepTime)).thenAnswer((invocation) async => Left(CacheFailure("Couldn't update sleeptime")));

        // act
        var result = await viewModel.updateSleepTime(sleepTime);
        var expectedResult = result.fold((failure) => failure, (_) {});

        // assert
        verify(() => mockUserRepository.updateSleepTime(sleepTime));
        expect(expectedResult, isA<CacheFailure>());
      });
    });
  });

  group('updateUser', () {
    var userEntity = UserEntity(
      sleepTime: const TimeOfDay(hour: 22, minute: 0),
      wakeUpTime: const TimeOfDay(hour: 10, minute: 0),
    );

    var userEntityIncomplete = UserEntity();

    double dailyDrinkingGoal = 2500;

    test('Should update user when successful', () async {
      // arrange
      when(() => mockValidateUserEntityUseCase(any())).thenReturn(const Right(null));
      when(() => mockUserRepository.updateWeight(any())).thenAnswer((_) async => const Right(null));
      when(() => mockUserRepository.updateSleepTime(any())).thenAnswer((_) async => const Right(null));
      when(() => mockUserRepository.updateWakeUpTime(any())).thenAnswer((_) async => const Right(null));
      when(() => mockUserRepository.updateWeeklyWorkoutDays(any())).thenAnswer((_) async => const Right(null));
      when(() => mockCalculateDailyDrinkingGoalUseCase()).thenAnswer((_) async => Right(dailyDrinkingGoal));
      when(() => mockUserRepository.updateDailyDrinkingGoal(any())).thenAnswer((_) async => const Right(null));

      // act
      var result = await viewModel.updateUser(userEntity);

      // assert
      verify(() => mockValidateUserEntityUseCase(userEntity));
      verify(() => mockUserRepository.updateWeight(userEntity.weight));
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(userEntity.weeklyWorkoutDays));
      verify(() => mockUserRepository.updateWakeUpTime(userEntity.wakeUpTime!));
      verify(() => mockUserRepository.updateSleepTime(userEntity.sleepTime!));
      verify(() => mockCalculateDailyDrinkingGoalUseCase());
      verify(() => mockUserRepository.updateDailyDrinkingGoal(dailyDrinkingGoal.toInt()));

      verifyNoMoreInteractions(mockUserRepository);

      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockValidateUserEntityUseCase(any())).thenReturn(const Right(null));

      when(() => mockUserRepository.updateWeight(any())).thenAnswer((_) async => const Right(null));
      when(() => mockUserRepository.updateSleepTime(any())).thenAnswer((_) async => Left(CacheFailure("Couldn't update sleeptime")));
      when(() => mockUserRepository.updateWakeUpTime(any())).thenAnswer((_) async => const Right(null));
      when(() => mockUserRepository.updateWeeklyWorkoutDays(any())).thenAnswer((_) async => const Right(null));

      // act
      var validationResult = mockValidateUserEntityUseCase(userEntity);

      var result = await viewModel.updateUser(userEntity);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockValidateUserEntityUseCase(userEntity));
      verify(() => mockUserRepository.updateWeight(userEntity.weight));
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(userEntity.weeklyWorkoutDays));
      verify(() => mockUserRepository.updateWakeUpTime(userEntity.wakeUpTime!));
      verify(() => mockUserRepository.updateSleepTime(userEntity.sleepTime!));
      verifyNoMoreInteractions(mockUserRepository);

      expect(validationResult, const Right(null));
      expect(expectedResult, isA<CacheFailure>());
    });

    test('Should return ValidationFailure when validation fails', () async {
      // arrange
      when(() => mockValidateUserEntityUseCase(any())).thenReturn(Left(ValidationFailures.wakeUpTime));

      // act
      var result = await viewModel.updateUser(userEntityIncomplete);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockValidateUserEntityUseCase(userEntityIncomplete));
      verifyZeroInteractions(mockUserRepository);

      expect(expectedResult, isA<ValidationFailure>());
    });
  });
}
