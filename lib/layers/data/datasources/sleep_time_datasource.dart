import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';

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

    return box.get(SLEEP_TIME);
  }

  @override
  Future<void> update(TimeOfDay value) {
    var box = _hiveInterface.box(USER_DATA);

    return box.put(SLEEP_TIME, value);
  }
}
