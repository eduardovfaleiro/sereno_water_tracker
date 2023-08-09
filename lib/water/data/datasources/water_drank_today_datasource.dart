import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class WaterDrankTodayDataSource {
  Future<int> get();
  Future<void> set(int value);
  Future<void> remove(int value);
  Future<void> add(int value);
}

class HiveWaterDrankTodayDataSource implements WaterDrankTodayDataSource {
  final HiveInterface _hiveInterface;

  HiveWaterDrankTodayDataSource(this._hiveInterface);

  @override
  Future<int> add(int amount) async {
    int amountOfWaterDrankToday =
        _hiveInterface.box(WATER).get(WATER_DRANK_TODAY);
    int amountOfWaterDrankTodayAddedUp = amountOfWaterDrankToday + amount;

    await _hiveInterface
        .box(WATER)
        .put(WATER_DRANK_TODAY, amountOfWaterDrankTodayAddedUp);

    return amountOfWaterDrankTodayAddedUp;
  }

  @override
  Future<int> get() async {
    return _hiveInterface.box(WATER).get(WATER_DRANK_TODAY);
  }

  @override
  Future<void> remove(int amount) async {
    int amountOfWaterDrankToday =
        _hiveInterface.box(WATER).get(WATER_DRANK_TODAY);
    int amountOfWaterDrankTodayRemoved = amountOfWaterDrankToday - amount;

    await _hiveInterface
        .box(WATER)
        .put(WATER_DRANK_TODAY, amountOfWaterDrankTodayRemoved);
  }

  // TODO: test method
  @override
  Future<void> set(int amount) async {
    return _hiveInterface.box(WATER).put(WATER_DRANK_TODAY, amount);
  }
}
