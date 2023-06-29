import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/user_entity.dart';

abstract interface class UserDataSource {
  Future<void> updateWeight(double weight);
  Future<void> updateSleepTime(TimeOfDay sleepTime);
  Future<void> updateWakeUpTime(TimeOfDay wakeUpTime);
  Future<void> updateWeeklyWorkoutDays(int weeklyWorkoutDays);
  Future<UserEntity> getUser();
}

class HiveUserDataSourceImp implements UserDataSource {
  final HiveInterface _hiveInterface;

  HiveUserDataSourceImp(this._hiveInterface);

  @override
  Future<void> updateSleepTime(TimeOfDay sleepTime) async {
    await _hiveInterface.box(USER_DATA).put(SLEEP_TIME, sleepTime);
  }

  @override
  Future<void> updateWakeUpTime(TimeOfDay wakeUpTime) async {
    await _hiveInterface.box(USER_DATA).put(WAKE_UP_TIME, wakeUpTime);
  }

  @override
  Future<void> updateWeeklyWorkoutDays(int weeklyWorkoutDays) async {
    await _hiveInterface.box(USER_DATA).put(WEEKLY_WORKOUT_DAYS, weeklyWorkoutDays);
  }

  @override
  Future<void> updateWeight(double weight) async {
    await _hiveInterface.box(USER_DATA).put(WEIGHT, weight);
  }

  @override
  Future<UserEntity> getUser() async {
    var box = _hiveInterface.box(USER_DATA);
    UserEntity userEntity;

    // final double weight;
    // final int dailyDrinkingFrequency;
    // final int weeklyWorkoutDays;
    // final TimeOfDay? sleepTime;
    // final TimeOfDay? wakeUpTime;

    var weight = await box.get(WEIGHT);
    var weeklyWorkoutDays = await box.get(DAILY_DRINKING_FREQUENCY);
    var weeklyWorkoutDays = await box.get(WEEKLY_WORKOUT_DAYS)
  }
}
