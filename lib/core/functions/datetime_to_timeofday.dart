import 'package:flutter/material.dart';

extension ConversionToTimeOfDay on DateTime {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}
