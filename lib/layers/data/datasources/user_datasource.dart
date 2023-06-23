import 'package:flutter/material.dart';

abstract interface class UserDataSource {
  Future<void> updateWeight(double weight);
  Future<void> updateSleepTime(TimeOfDay sleepTime);
  Future<void> updateWakeUpTime(TimeOfDay wakeUpTime);
  Future<void> updateWeeklyWorkoutDays(int weeklyWorkoutDays);
  Future<void> updateTimesToDrinkPerDay(int timesToDrinkPerDay);
}
