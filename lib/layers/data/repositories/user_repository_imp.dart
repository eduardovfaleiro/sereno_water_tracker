import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/daily_goal_datasource.dart';
import '../datasources/sleep_time_datasource.dart';
import '../datasources/wake_up_time_datasource.dart';
import '../datasources/weekly_workout_days_datasource.dart';
import '../datasources/weight_datasource.dart';

class UserRepositoryImp implements UserRepository {
  final WeightDataSource _weightDataSource;
  final WeeklyWorkoutDaysDataSource _weeklyWorkoutDaysDataSource;
  final WakeUpTimeDataSource _wakeUpTimeDataSource;
  final SleepTimeDataSource _sleepTimeDataSource;
  final DailyDrinkingGoalDataSource _dailyDrinkingGoalDataSource;

  UserRepositoryImp(this._weightDataSource, this._weeklyWorkoutDaysDataSource, this._wakeUpTimeDataSource, this._sleepTimeDataSource, this._dailyDrinkingGoalDataSource);

  @override
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) async {
    return Right(await _sleepTimeDataSource.update(sleepTime));
  }

  @override
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) async {
    return Right(await _wakeUpTimeDataSource.update(wakeUpTime));
  }

  @override
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) async {
    return Right(await _weeklyWorkoutDaysDataSource.update(weeklyWorkoutDays));
  }

  @override
  Future<Result<void>> updateWeight(int weight) async {
    return Right(await _weightDataSource.update(weight));
  }

  // TODO: test
  @override
  Future<Result<int>> getWeight() async {
    return Right(await _weightDataSource.get());
  }

  // TODO: test
  @override
  Future<Result<int>> getWeeklyWorkoutDays() async {
    return Right(await _weeklyWorkoutDaysDataSource.get());
  }

  // TODO: test
  @override
  Future<Result<void>> updateDailyDrinkingGoal(int amount) async {
    return Right(await _dailyDrinkingGoalDataSource.update(amount));
  }
}
