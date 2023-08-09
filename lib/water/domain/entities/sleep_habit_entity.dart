import 'package:flutter/material.dart';

class SleepHabitEntity {
  final TimeOfDay wakeUpTime;
  final TimeOfDay sleeptime;

  SleepHabitEntity({required this.wakeUpTime, required this.sleeptime});

  Duration get timeAwaken {
    final dateTime = DateTime(1);

    final wakeUpDateTime = dateTime.copyWith(
      hour: wakeUpTime.hour,
      minute: wakeUpTime.minute,
    );

    final DateTime sleepDateTime = () {
      var sleepDateTime = dateTime.copyWith(
        hour: sleeptime.hour,
        minute: sleeptime.minute,
      );

      if (wakeUpDateTime.isAfter(sleepDateTime) || wakeUpDateTime.isAtSameMomentAs(sleepDateTime)) {
        return dateTime.copyWith(
          day: dateTime.day + 1,
          hour: sleeptime.hour,
          minute: sleeptime.minute,
        );
      }

      return sleepDateTime;
    }();

    final Duration timeAwaken = sleepDateTime.difference(wakeUpDateTime);

    return timeAwaken;
  }
}
