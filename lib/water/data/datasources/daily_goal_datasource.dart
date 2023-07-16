import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class DailyDrinkingGoalDataSource {
  Future<int> get();
  Future<void> update(int amount);
}

class HiveDailyDrinkingGoalDataSource implements DailyDrinkingGoalDataSource {
  final HiveInterface _hiveInterface;

  HiveDailyDrinkingGoalDataSource(this._hiveInterface);

  @override
  Future<int> get() async {
    return _hiveInterface.box(WATER_DATA).get(DAILY_DRINKING_GOAL);
  }

  @override
  Future<void> update(int amount) async {
    return _hiveInterface.box(WATER_DATA).put(DAILY_DRINKING_GOAL, amount);
  }
}
