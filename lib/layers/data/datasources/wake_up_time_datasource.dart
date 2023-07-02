import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';

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

    return box.get(WAKE_UP_TIME);
  }

  @override
  Future<void> update(TimeOfDay value) {
    var box = _hiveInterface.box(USER_DATA);

    return box.put(WAKE_UP_TIME, value);
  }
}
