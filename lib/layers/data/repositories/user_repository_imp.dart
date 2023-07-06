import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/sleep_time_datasource.dart';
import '../datasources/wake_up_time_datasource.dart';
import '../datasources/weekly_workout_days_datasource.dart';
import '../datasources/weight_datasource.dart';

class UserRepositoryImp implements UserRepository {
  final WeightDataSource _weightDataSource;
  final WeeklyWorkoutDaysDataSource _weeklyWorkoutDaysDataSource;
  final WakeUpTimeDataSource _wakeUpTimeDataSource;
  final SleepTimeDataSource _sleepTimeDataSource;

  UserRepositoryImp(this._weightDataSource, this._weeklyWorkoutDaysDataSource, this._wakeUpTimeDataSource, this._sleepTimeDataSource);

  @override
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) async {
    // try {
    return Right(await _sleepTimeDataSource.update(sleepTime));
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) async {
    // try {
    return Right(await _wakeUpTimeDataSource.update(wakeUpTime));
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) async {
    // try {
    return Right(await _weeklyWorkoutDaysDataSource.update(weeklyWorkoutDays));
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<void>> updateWeight(double weight) async {
    // try {
    return Right(await _weightDataSource.update(weight));
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }
}
