import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/utils/functions/get_time_of_day_value.dart';

abstract interface class SleepTimeDataSource {
  Future<TimeOfDay> get();
  Future<void> update(TimeOfDay value);
}

class HiveSleepTimeDataSourceImp implements SleepTimeDataSource {
  final HiveInterface _hiveInterface;

  HiveSleepTimeDataSourceImp(this._hiveInterface);

  @override
  Future<TimeOfDay> get() async {
    var box = _hiveInterface.box(USER_DATA);

    List<String> sleepTime = box.get(SLEEP_TIME).split(':');

    return TimeOfDay(hour: int.parse(sleepTime.first), minute: int.parse(sleepTime.last));
  }

  @override
  Future<void> update(TimeOfDay value) {
    var box = _hiveInterface.box(USER_DATA);

    return box.put(SLEEP_TIME, getTimeOfDayValue(value));
  }
}
