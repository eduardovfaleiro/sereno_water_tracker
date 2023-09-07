import 'package:flutter/material.dart';

import '../../../core/functions/calculate_water_data_functions.dart';
import '../entities/user_entity.dart';
import '../entities/water_data_entity.dart';

abstract class CalculateWaterDataByParametersUseCase {
  WaterDataEntity call({required UserEntity userEntity, required int dailyDrinkingFrequency});
}

class CalculateWaterDataByParametersUseCaseImp implements CalculateWaterDataByParametersUseCase {
  @override
  WaterDataEntity call({required UserEntity userEntity, required int dailyDrinkingFrequency}) {
    int dailyGoal = calculateDailyDrinkingGoal(
      weeklyWorkoutDays: userEntity.weeklyWorkoutDays,
      weight: userEntity.weight,
    );

    List<TimeOfDay> timesToDrink = calculateTimesToDrink(
      dailyDrinkingFrequency: dailyDrinkingFrequency,
      sleepHabitEntity: userEntity.sleepHabit,
    );

    int drankToday = 0;

    return WaterDataEntity(
      drankToday: drankToday,
      dailyGoal: dailyGoal,
      dailyDrinkingFrequency: dailyDrinkingFrequency,
      timesToDrink: timesToDrink,
    );
  }
}
