import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/utils/functions/get_time_of_day_value.dart';

abstract interface class WakeUpTimeDataSource {
  Future<TimeOfDay> get();
  Future<void> update(TimeOfDay value);
}

class HiveWakeUpTimeDataSourceImp implements WakeUpTimeDataSource {
  final HiveInterface _hiveInterface;

  HiveWakeUpTimeDataSourceImp(this._hiveInterface);

  @override
  Future<TimeOfDay> get() async {
    var box = _hiveInterface.box(USER_DATA);

    List<String> wakeUpTime = box.get(WAKE_UP_TIME).split(':');

    return TimeOfDay(hour: int.parse(wakeUpTime.first), minute: int.parse(wakeUpTime.last));
  }

  @override
  Future<void> update(TimeOfDay value) {
    var box = _hiveInterface.box(USER_DATA);

    return box.put(WAKE_UP_TIME, getTimeOfDayValue(value));
  }
}
