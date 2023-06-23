import 'package:flutter/material.dart';

String getTimeOfDayValue(TimeOfDay timeOfDay) {
  return '${timeOfDay.hour}:${timeOfDay.minute.toString().padRight(2, '0')}';
}
