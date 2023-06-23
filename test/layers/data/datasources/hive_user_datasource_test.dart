import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';

abstract interface class UserDataSource {
  Future<void> updateWeight(double weight);
  Future<void> updateSleepTime(TimeOfDay sleepTime);
  Future<void> updateWakeUpTime(TimeOfDay wakeUpTime);
  Future<void> updateWeeklyWorkoutDays(int weeklyWorkoutDays);
  Future<void> updateTimesToDrinkPerDay(int timesToDrinkPerDay);
}

class HiveUserDataSourceImp implements UserDataSource {
  final HiveInterface _hiveInterface;

  HiveUserDataSourceImp(this._hiveInterface);

  @override
  Future<void> updateSleepTime(TimeOfDay sleepTime) async {
    _hiveInterface.box(USER_DATA).put(SLEEP_TIME, sleepTime);
  }

  @override
  Future<void> updateTimesToDrinkPerDay(int timesToDrinkPerDay) {
    // TODO: implement updateTimesToDrinkPerDay
    throw UnimplementedError();
  }

  @override
  Future<void> updateWakeUpTime(TimeOfDay wakeUpTime) {
    // TODO: implement updateWakeUpTime
    throw UnimplementedError();
  }

  @override
  Future<void> updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    // TODO: implement updateWeeklyWorkoutDays
    throw UnimplementedError();
  }

  @override
  Future<void> updateWeight(double weight) {
    // TODO: implement updateWeight
    throw UnimplementedError();
  }
}

void main() {}
