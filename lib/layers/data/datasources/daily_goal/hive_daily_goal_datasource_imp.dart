import 'package:hive/hive.dart';

import '../../../../core/core.dart';
import 'daily_goal_datasource.dart';

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
