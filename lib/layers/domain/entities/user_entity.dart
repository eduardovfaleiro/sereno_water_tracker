// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class UserEntity {
  final double weight;
  final int dailyDrinkingFrequency;
  final int weeklyWorkoutDays;
  final TimeOfDay? sleepTime;
  final TimeOfDay? wakeUpTime;

  UserEntity({
    this.weight = MIN_WEIGHT,
    this.dailyDrinkingFrequency = 1,
    this.weeklyWorkoutDays = 0,
    this.sleepTime,
    this.wakeUpTime,
  });

  UserEntity copyWith({
    double? weight,
    int? dailyDrinkingFrequency,
    int? weeklyWorkoutDays,
    TimeOfDay? sleepTime,
    TimeOfDay? wakeUpTime,
  }) {
    return UserEntity(
      weight: weight ?? this.weight,
      dailyDrinkingFrequency: dailyDrinkingFrequency ?? this.dailyDrinkingFrequency,
      weeklyWorkoutDays: weeklyWorkoutDays ?? this.weeklyWorkoutDays,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
    );
  }
}
