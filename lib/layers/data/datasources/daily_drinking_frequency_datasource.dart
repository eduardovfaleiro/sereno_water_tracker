import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class DailyDrinkingFrequencyDataSource {
  Future<int> get();
}

class HiveDailyDrinkingFrequencyDataSourceImp implements DailyDrinkingFrequencyDataSource {
  final HiveInterface _hiveInterface;

  HiveDailyDrinkingFrequencyDataSourceImp(this._hiveInterface);

  @override
  Future<int> get() async {
    return _hiveInterface.box(USER_DATA).get(DAILY_DRINKING_FREQUENCY);
  }
}
