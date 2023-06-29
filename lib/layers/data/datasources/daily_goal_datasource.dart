import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class DailyGoalDataSource {
  Future<int> get();
  Future<int> update();
  Future<void> create(int amount);
}

class HiveDailyGoalDataSource implements DailyGoalDataSource {
  final HiveInterface _hiveInterface;

  HiveDailyGoalDataSource(this._hiveInterface);

  @override
  Future<void> create(int amount) async {
    _hiveInterface.box(WATER_DATA).put(DAILY_GOAL, amount);
  }

  @override
  Future<int> get() async {
    return _hiveInterface.box(WATER_DATA).get(DAILY_GOAL);
  }

  @override
  Future<int> update() {
    throw UnimplementedError();
  }
}
