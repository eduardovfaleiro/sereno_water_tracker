import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../entities/user_entity.dart';

// test
abstract interface class UserRepository {
  Future<Result<void>> updateWeight(double weight);
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime);
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime);
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays);
  Future<Result<UserEntity>> getUser();
}
