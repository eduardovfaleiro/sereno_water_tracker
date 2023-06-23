// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class UserEntity {
  final double weight;
  final int timesToDrinkPerDay;
  final int weeklyWorkoutDays;
  final TimeOfDay? sleepTime;
  final TimeOfDay? wakeUpTime;

  UserEntity({
    this.weight = MIN_WEIGHT,
    this.timesToDrinkPerDay = 1,
    this.weeklyWorkoutDays = 0,
    this.sleepTime,
    this.wakeUpTime,
  });

  UserEntity copyWith({
    double? weight,
    int? timesToDrinkPerDay,
    int? weeklyWorkoutDays,
    TimeOfDay? sleepTime,
    TimeOfDay? wakeUpTime,
  }) {
    return UserEntity(
      weight: weight ?? this.weight,
      timesToDrinkPerDay: timesToDrinkPerDay ?? this.timesToDrinkPerDay,
      weeklyWorkoutDays: weeklyWorkoutDays ?? this.weeklyWorkoutDays,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
    );
  }
}
