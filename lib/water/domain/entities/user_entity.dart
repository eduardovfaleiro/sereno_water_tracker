// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'sleep_habit_entity.dart';

class UserEntity {
  int weight;
  int weeklyWorkoutDays;
  TimeOfDay sleeptime;
  TimeOfDay wakeUpTime;

  UserEntity({
    required this.weight,
    required this.weeklyWorkoutDays,
    required this.sleeptime,
    required this.wakeUpTime,
  });

  set sleepHabit(SleepHabitEntity value) {
    sleeptime = value.sleeptime;
    wakeUpTime = value.wakeUpTime;
  }

  SleepHabitEntity get sleepHabit {
    return SleepHabitEntity(wakeUpTime: wakeUpTime, sleeptime: sleeptime);
  }

  UserEntity copyWith({
    int? weight,
    int? weeklyWorkoutDays,
    TimeOfDay? sleeptime,
    TimeOfDay? wakeUpTime,
  }) {
    return UserEntity(
      weight: weight ?? this.weight,
      weeklyWorkoutDays: weeklyWorkoutDays ?? this.weeklyWorkoutDays,
      sleeptime: sleeptime ?? this.sleeptime,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
    );
  }
}

class UserEntityDefaultWithDailyGoal extends UserEntityWithDailyGoal {
  UserEntityDefaultWithDailyGoal({super.dailyGoal})
      : super(
          sleeptime: DEFAULT_SLEEPTIME,
          wakeUpTime: DEFAULT_WAKE_UP_TIME,
          weeklyWorkoutDays: DEFAULT_WEEKLY_WORKOUT_DAYS,
          weight: DEFAULT_WEIGHT,
        );
}

class UserEntityWithDailyGoal extends UserEntity {
  int? dailyGoal;

  UserEntityWithDailyGoal({
    required this.dailyGoal,
    required super.weight,
    required super.weeklyWorkoutDays,
    required super.sleeptime,
    required super.wakeUpTime,
  });

  @override
  UserEntityWithDailyGoal copyWith({
    int? dailyGoal,
    int? weight,
    int? weeklyWorkoutDays,
    TimeOfDay? sleeptime,
    TimeOfDay? wakeUpTime,
  }) {
    return UserEntityWithDailyGoal(
      dailyGoal: dailyGoal ?? this.dailyGoal,
      sleeptime: sleeptime ?? this.sleeptime,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      weeklyWorkoutDays: weeklyWorkoutDays ?? this.weeklyWorkoutDays,
      weight: weight ?? this.weight,
    );
  }
}

class UserEntityDefault extends UserEntity {
  UserEntityDefault()
      : super(
          sleeptime: DEFAULT_SLEEPTIME,
          wakeUpTime: DEFAULT_WAKE_UP_TIME,
          weeklyWorkoutDays: DEFAULT_WEEKLY_WORKOUT_DAYS,
          weight: DEFAULT_WEIGHT,
        );
}
