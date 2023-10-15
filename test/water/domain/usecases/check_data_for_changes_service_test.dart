import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_water_tracker/core/core.dart';
import 'package:sereno_water_tracker/water/data/repositories/user_repository.dart';
import 'package:sereno_water_tracker/water/data/repositories/water_repository.dart';
import 'package:sereno_water_tracker/water/domain/entities/water_data_entity.dart';
import 'package:sereno_water_tracker/water/domain/services/check_data_for_changes_service.dart';
import 'package:sereno_water_tracker/water/domain/usecases/calculate_water_data_usecase.dart';

class MockWaterRepository extends Mock implements WaterRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockCalculateWaterDataUseCase extends Mock implements CalculateWaterDataUseCase {}

void main() {
  final mockUserRepository = MockUserRepository();
  final mockCalculateWaterDataUseCase = MockCalculateWaterDataUseCase();
  final useCase = CheckDataForChangesServiceImp(mockUserRepository, mockCalculateWaterDataUseCase);

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

      final waterDataEntity = WaterDataEntity.empty().copyWith(dailyGoal: actualDailyGoal);

      int dailyGoalToCompare = 3000;

      // arrange
      when(() => mockCalculateWaterDataUseCase()).thenAnswer((invocation) async => Right(waterDataEntity));

      // act
      final result = await getResult(useCase.isDailyGoalCustom(dailyGoalToCompare));

      // assert
      verify(() => mockCalculateWaterDataUseCase());

      expect(result, false);
    });

    test('Should return true', () async {
      int actualDailyGoal = 400;

      final waterDataEntity = WaterDataEntity.empty().copyWith(dailyGoal: actualDailyGoal);

      int dailyGoalToCompare = 100;

      // arrange
      when(() => mockCalculateWaterDataUseCase()).thenAnswer((invocation) async => Right(waterDataEntity));

      // act
      final result = await getResult(useCase.isDailyGoalCustom(dailyGoalToCompare));

      // assert
      verify(() => mockCalculateWaterDataUseCase());

      expect(result, true);
    });
  });

  // TODO: implement the rest, like dailyDrinkingFrequency
}
