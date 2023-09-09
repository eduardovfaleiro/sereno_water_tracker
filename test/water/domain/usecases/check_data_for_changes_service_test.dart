import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/water_repository.dart';
import 'package:sereno_clean_architecture_solid/water/domain/services/check_data_for_changes_service.dart';

class MockWaterRepository extends Mock implements WaterRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final mockUserRepository = MockUserRepository();
  final mockWaterRepository = MockWaterRepository();
  final useCase = CheckDataForChangesServiceImp(mockUserRepository, mockWaterRepository);

  group('weeklyWorkoutDays', () {
    test('Should return true', () async {
      const repositoryWeeklyWorkoutDays = 5;
      const weeklyWorkoutDays = 3;

      // arrange
      when(() => mockUserRepository.getWeeklyWorkoutDays()).thenAnswer((invocation) async {
        return const Right(repositoryWeeklyWorkoutDays);
      });

      // act
      final result = await getResult(useCase.weeklyWorkoutDays(weeklyWorkoutDays));

      // assert
      verify(() => mockUserRepository.getWeeklyWorkoutDays());
      verifyNoMoreInteractions(mockUserRepository);

      expect(result, true);
    });

    test('Should return false', () async {
      const repositoryWeeklyWorkoutDays = 5;
      const weeklyWorkoutDays = 5;

      // arrange
      when(() => mockUserRepository.getWeeklyWorkoutDays()).thenAnswer((invocation) async {
        return const Right(repositoryWeeklyWorkoutDays);
      });

      // act
      final result = await getResult(useCase.weeklyWorkoutDays(weeklyWorkoutDays));

      // assert
      verify(() => mockUserRepository.getWeeklyWorkoutDays());
      verifyNoMoreInteractions(mockUserRepository);

      expect(result, false);
    });
  });

  group('weight', () {
    test('Should return true', () async {
      const repositoryWeight = 45;
      const weight = 55;

      // arrange
      when(() => mockUserRepository.getWeight()).thenAnswer((invocation) async {
        return const Right(repositoryWeight);
      });

      // act
      final result = await getResult(useCase.weight(weight));

      // assert
      verify(() => mockUserRepository.getWeight());
      verifyNoMoreInteractions(mockUserRepository);

      expect(result, true);
    });

    test('Should return false', () async {
      const repositoryWeight = 45;
      const weight = 45;

      // arrange
      when(() => mockUserRepository.getWeight()).thenAnswer((invocation) async {
        return const Right(repositoryWeight);
      });

      // act
      final result = await getResult(useCase.weight(weight));

      // assert
      verify(() => mockUserRepository.getWeight());
      verifyNoMoreInteractions(mockUserRepository);

      expect(result, false);
    });
  });

  group('isDailyGoalCustom', () {
    test('Should return false', () async {
      int actualDailyGoal = 3000;
      int dailyGoalToCompare = 3000;

      // arrange
      when(() => mockWaterRepository.getDailyDrinkingGoal()).thenAnswer((invocation) async => Right(actualDailyGoal));

      // act
      final result = await getResult(useCase.isDailyGoalCustom(dailyGoalToCompare));

      // assert
      verify(() => mockWaterRepository.getDailyDrinkingGoal());

      expect(result, false);
    });

    test('Should return true', () async {
      int actualDailyGoal = 400;
      int dailyGoalToCompare = 100;

      // arrange
      when(() => mockWaterRepository.getDailyDrinkingGoal()).thenAnswer((invocation) async => Right(actualDailyGoal));

      // act
      final result = await getResult(useCase.isDailyGoalCustom(dailyGoalToCompare));

      // assert
      verify(() => mockWaterRepository.getDailyDrinkingGoal());

      expect(result, true);
    });
  });

  // TODO: implement the rest, like dailyDrinkingFrequency
}
