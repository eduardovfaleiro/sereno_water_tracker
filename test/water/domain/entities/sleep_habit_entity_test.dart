import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/sleep_habit_entity.dart';

void main() {
  group('timeAwaken', () {
    test('Should return correct duration when wake up time is "bigger"', () async {
      final sleepHabit = SleepHabitEntity(
        wakeUpTime: const TimeOfDay(hour: 12, minute: 0),
        sleeptime: const TimeOfDay(hour: 0, minute: 0),
      );

      final result = sleepHabit.timeAwaken;

      expect(result, const Duration(hours: 12));
    });

    test('Should return correct duration when wake up time is "smaller"', () async {
      final sleepHabit = SleepHabitEntity(
        wakeUpTime: const TimeOfDay(hour: 0, minute: 30),
        sleeptime: const TimeOfDay(hour: 23, minute: 0),
      );

      final result = sleepHabit.timeAwaken;

      expect(result, const Duration(hours: 22, minutes: 30));
    });

    test('Should return correct duration when wake up time is the "same" as sleeptime', () async {
      final sleepHabit = SleepHabitEntity(
        wakeUpTime: const TimeOfDay(hour: 0, minute: 0),
        sleeptime: const TimeOfDay(hour: 0, minute: 0),
      );

      final result = sleepHabit.timeAwaken;

      expect(result, const Duration(hours: 24));
    });
  });
}
