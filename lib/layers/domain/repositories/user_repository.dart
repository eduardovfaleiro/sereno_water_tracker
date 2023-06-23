import 'package:flutter/material.dart';

import '../../../core/core.dart';

// test
abstract interface class UserRepository {
  Future<Result<void>> updateWeight(double weight);
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime);
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime);
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays);
  Future<Result<void>> updateTimesToDrinkPerDay(int timesToDrinkPerDay);
}
