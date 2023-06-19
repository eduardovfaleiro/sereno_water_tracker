import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class TimesToDrinkPerDayDataSource {
  Future<int> get();
}

class HiveTimesToDrinkPerDayDataSourceImp implements TimesToDrinkPerDayDataSource {
  final HiveInterface _hiveInterface;

  HiveTimesToDrinkPerDayDataSourceImp(this._hiveInterface);

  @override
  Future<int> get() async {
    return _hiveInterface.box(USER_DATA).get(DAILY_DRINKING_FREQUENCY);
  }
}
