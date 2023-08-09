import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/functions/datetime_to_timeofday.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../entities/sleep_habit_entity.dart';
import '../entities/user_entity.dart';
import '../entities/water_data_entity.dart';

abstract class CalculateWaterDataUseCase {
  Future<Result<WaterDataEntity>> call();
}

class CalculateWaterDataUseCaseImp implements CalculateWaterDataUseCase {
  final UserRepository _userRepository;
  final WaterRepository _waterRepository;

  CalculateWaterDataUseCaseImp(this._userRepository, this._waterRepository);

  @override
  Future<Result<WaterDataEntity>> call() async {
    final userResult = await getResult(_userRepository.getUser());
    final dailyDrinkingFrequencyResult = await getResult(_waterRepository.getDailyDrinkingFrequency());

    if (userResult is Failure) return Left(userResult);
    if (dailyDrinkingFrequencyResult is Failure) return Left(dailyDrinkingFrequencyResult);

    UserEntity userEntity = userResult;
    int dailyDrinkingFrequency = dailyDrinkingFrequencyResult;

    int dailyDrinkingGoal = calculateDailyDrinkingGoal(
      weeklyWorkoutDays: userEntity.weeklyWorkoutDays,
      weight: userEntity.weight,
    );

    List<TimeOfDay> timesToDrink = calculateTimesToDrink(
      sleepHabitEntity: userEntity.sleepHabit,
      dailyDrinkingFrequency: dailyDrinkingFrequency,
    );

    int drankToday = 0;

    return Right(
      WaterDataEntity(
        drankToday: drankToday,
        dailyGoal: dailyDrinkingGoal,
        dailyDrinkingFrequency: dailyDrinkingFrequency,
        timesToDrink: timesToDrink,
      ),
    );
  }
}

int calculateDailyDrinkingGoal({
  required int weeklyWorkoutDays,
  required int weight,
}) {
  return (weight * 35 + ((weeklyWorkoutDays * 500) / DAYS_IN_A_WEEK)).toInt();
}

List<TimeOfDay> calculateTimesToDrink({
  required SleepHabitEntity sleepHabitEntity,
  required int dailyDrinkingFrequency,
}) {
  Duration timeAwaken = sleepHabitEntity.timeAwaken;

  int intervalInMin = timeAwaken.inMinutes ~/ dailyDrinkingFrequency;

  List<TimeOfDay> timesToDrink = [];

  DateTime lastTime = DateTime(1).copyWith(
    hour: sleepHabitEntity.wakeUpTime.hour,
    minute: sleepHabitEntity.wakeUpTime.minute,
  );

  for (int i = 0; i < dailyDrinkingFrequency; i++) {
    timesToDrink.add(lastTime.toTimeOfDay());

    lastTime = lastTime.add(Duration(minutes: intervalInMin));
  }

  return timesToDrink;
}
