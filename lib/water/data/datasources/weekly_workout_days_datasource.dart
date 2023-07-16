import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class WeeklyWorkoutDaysDataSource {
  Future<int> get();
  Future<void> update(int value);
}

class HiveWeeklyWorkoutDaysDataSourceImp implements WeeklyWorkoutDaysDataSource {
  final HiveInterface _hiveInterface;

  HiveWeeklyWorkoutDaysDataSourceImp(this._hiveInterface);

  @override
  Future<int> get() async {
    var box = _hiveInterface.box(USER_DATA);

    return box.get(WEEKLY_WORKOUT_DAYS);
  }

  @override
  Future<void> update(int value) {
    var box = _hiveInterface.box(USER_DATA);

    return box.put(WEEKLY_WORKOUT_DAYS, value);
  }
}
