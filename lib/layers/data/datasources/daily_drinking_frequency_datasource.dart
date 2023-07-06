import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class NumberOfTimesToDrinkWaterDailyDataSource {
  Future<int> get();
  Future<void> update(int times);
}

class HiveNumberOfTimesToDrinkWaterDailyDataSourceImp implements NumberOfTimesToDrinkWaterDailyDataSource {
  final HiveInterface _hiveInterface;

  HiveNumberOfTimesToDrinkWaterDailyDataSourceImp(this._hiveInterface);

  @override
  Future<int> get() async {
    return _hiveInterface.box(USER_DATA).get(DAILY_DRINKING_FREQUENCY);
  }

  @override
  Future<void> update(int times) {
    return _hiveInterface.box(USER_DATA).put(DAILY_DRINKING_FREQUENCY, times);
  }
}
