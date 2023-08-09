import 'package:flutter/material.dart';

class TimeOfDayUtils {
  final TimeOfDay timeOfDay;

  TimeOfDayUtils(this.timeOfDay);

  static TimeOfDay fromString(String str) {
    List<String> hourAndMinute = str.split(':');

    return TimeOfDay(
      hour: int.parse(hourAndMinute.first),
      minute: int.parse(hourAndMinute.last),
    );
  }

  String toLiteral() {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }
}
