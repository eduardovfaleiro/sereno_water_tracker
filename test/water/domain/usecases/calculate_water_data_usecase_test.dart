import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_water_tracker/core/core.dart';
import 'package:sereno_water_tracker/core/functions/calculate_water_data_functions.dart';
import 'package:sereno_water_tracker/water/data/repositories/user_repository.dart';
import 'package:sereno_water_tracker/water/data/repositories/water_repository.dart';
import 'package:sereno_water_tracker/water/domain/entities/sleep_habit_entity.dart';
import 'package:sereno_water_tracker/water/domain/entities/user_entity.dart';
import 'package:sereno_water_tracker/water/domain/entities/water_data_entity.dart';
import 'package:sereno_water_tracker/water/domain/usecases/calculate_water_data_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockWaterRepository extends Mock implements WaterRepository {}

void main() {
  final mockUserRepository = MockUserRepository();
  final mockWaterRepository = MockWaterRepository();

  final useCase = CalculateWaterDataUseCaseImp(mockUserRepository, mockWaterRepository);

  test('Should return the correct waterData', () async {
    final waterDataEntity = WaterDataEntity(
      drankToday: 0,
      dailyGoal: 3123,
      dailyDrinkingFrequency: 6,
      timesToDrink: [
        const TimeOfDay(hour: 3, minute: 30),
        const TimeOfDay(hour: 6, minute: 30),
        const TimeOfDay(hour: 9, minute: 30),
        const TimeOfDay(hour: 12, minute: 30),
        const TimeOfDay(hour: 15, minute: 30),
        const TimeOfDay(hour: 18, minute: 30),
      ],
    );

    // arrange
    when(() => mockUserRepository.getUser()).thenAnswer((_) async {
      return Right(
        UserEntity(
          weight: 77,
          weeklyWorkoutDays: 6,
          sleeptime: const TimeOfDay(hour: 3, minute: 30),
          wakeUpTime: const TimeOfDay(hour: 21, minute: 30),
        ),
      );
    });

    when(() => mockWaterRepository.getDailyDrinkingFrequency()).thenAnswer((_) async {
      return const Right(6);
    });

    // act
    final result = await getResult(useCase());

    // assert
    verify(() => mockUserRepository.getUser());
    verify(() => mockWaterRepository.getDailyDrinkingFrequency());

    expect(result, waterDataEntity);
  });

  group('calculateDailyDrinkingGoal', () {
    test('Should return correct daily drinking goal', () async {
      final result = calculateDailyDrinkingGoal(weeklyWorkoutDays: 6, weight: 77);

      expect(result, 3123);
    });
  });

  group('calculateTimesToDrink', () {
    test('Should ', () async {
      List<TimeOfDay> timesToDrink = [
        const TimeOfDay(hour: 6, minute: 0),
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 12, minute: 0),
        const TimeOfDay(hour: 15, minute: 0),
        const TimeOfDay(hour: 18, minute: 0),
        const TimeOfDay(hour: 21, minute: 0),
      ];

      final result = calculateTimesToDrink(
        sleepHabitEntity: SleepHabitEntity(
          wakeUpTime: const TimeOfDay(hour: 6, minute: 0),
          sleeptime: const TimeOfDay(hour: 0, minute: 0),
        ),
        dailyDrinkingFrequency: 6,
      );

      expect(result, timesToDrink);
    });
  });
}
