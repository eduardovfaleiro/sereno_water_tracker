import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class AmountOfWaterDrankTodayDataSource {
  Future<int> get();
  Future<void> update(int amount);
  Future<void> subtract(int amount);
  Future<void> addUp(int amount);
}

class HiveAmountOfWaterDrankTodayDataSourceImp implements AmountOfWaterDrankTodayDataSource {
  final HiveInterface _hiveInterface;

  HiveAmountOfWaterDrankTodayDataSourceImp(this._hiveInterface);

  @override
  Future<int> addUp(int amount) async {
    int amountOfWaterDrankToday = _hiveInterface.box(WATER_DATA).get(AMOUNT_OF_WATER_DRANK_TODAY);
    int amountOfWaterDrankTodayAddedUp = amountOfWaterDrankToday + amount;

    await _hiveInterface.box(WATER_DATA).put(AMOUNT_OF_WATER_DRANK_TODAY, amountOfWaterDrankTodayAddedUp);

    return amountOfWaterDrankTodayAddedUp;
  }

  @override
  Future<int> get() async {
    return _hiveInterface.box(WATER_DATA).get(AMOUNT_OF_WATER_DRANK_TODAY, defaultValue: 0);
  }

  @override
  Future<void> subtract(int amount) {
    throw UnimplementedError();
  }

  // TODO: test method
  @override
  Future<void> update(int amount) async {
    return _hiveInterface.box(WATER_DATA).put(AMOUNT_OF_WATER_DRANK_TODAY, amount);
  }
}
