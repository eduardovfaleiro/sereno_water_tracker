import 'package:flutter/material.dart';

import '../../water/domain/entities/sleep_habit_entity.dart';
import '../core.dart';
import 'datetime_to_timeofday.dart';

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
