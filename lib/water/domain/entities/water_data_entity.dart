// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WaterDataEntity {
  int drankToday;
  int dailyGoal;
  int dailyDrinkingFrequency;
  List<TimeOfDay> timesToDrink;

  WaterDataEntity({
    required this.drankToday,
    required this.dailyGoal,
    required this.dailyDrinkingFrequency,
    required this.timesToDrink,
  });

  factory WaterDataEntity.empty() {
    return WaterDataEntity(
      drankToday: 0,
      dailyGoal: 0,
      dailyDrinkingFrequency: 0,
      timesToDrink: [],
    );
  }

  double get drankTodayPercentage => drankToday / dailyGoal;

  @override
  bool operator ==(covariant WaterDataEntity other) {
    if (identical(this, other)) return true;

    return other.drankToday == drankToday &&
        other.dailyGoal == dailyGoal &&
        other.dailyDrinkingFrequency == dailyDrinkingFrequency;
  }

  @override
  int get hashCode => drankToday.hashCode ^ dailyGoal.hashCode ^ dailyDrinkingFrequency.hashCode;

  WaterDataEntity copyWith({
    int? drankToday,
    int? dailyGoal,
    int? dailyDrinkingFrequency,
    List<TimeOfDay>? timesToDrink,
  }) {
    return WaterDataEntity(
      drankToday: drankToday ?? this.drankToday,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      dailyDrinkingFrequency: dailyDrinkingFrequency ?? this.dailyDrinkingFrequency,
      timesToDrink: timesToDrink ?? this.timesToDrink,
    );
  }
}
