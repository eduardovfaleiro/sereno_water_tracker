import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/functions/calculate_water_data_functions.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/sleep_habit_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/user_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_data_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/calculate_water_data_by_parameters_usecase.dart';

void main() {
  int weight = 70;
  int weeklyWorkoutDays = 3;

  var sleeptime = const TimeOfDay(hour: 23, minute: 0);
  var wakeUpTime = const TimeOfDay(hour: 6, minute: 30);

  const dailyDrinkingFrequency = 5;

  final userEntity = UserEntity(
    weight: weight,
    weeklyWorkoutDays: weeklyWorkoutDays,
    sleeptime: sleeptime,
    wakeUpTime: wakeUpTime,
  );

  final useCase = CalculateWaterDataByParametersUseCaseImp();

  test('Should return correct waterDataEntity', () async {
    final int expectedDailyGoal = (weight * 35 + (weeklyWorkoutDays * 500 / DAYS_IN_A_WEEK)).toInt();

    final List<TimeOfDay> expectedTimesToDrink = calculateTimesToDrink(
      sleepHabitEntity: SleepHabitEntity(wakeUpTime: wakeUpTime, sleeptime: sleeptime),
      dailyDrinkingFrequency: dailyDrinkingFrequency,
    );

    final expectedWaterData = WaterDataEntity(
      drankToday: 0,
      dailyGoal: expectedDailyGoal,
      dailyDrinkingFrequency: dailyDrinkingFrequency,
      timesToDrink: expectedTimesToDrink,
    );

    final result = useCase(
      userEntity: userEntity,
      dailyDrinkingFrequency: dailyDrinkingFrequency,
    );

    expect(result, expectedWaterData);
  });
}
