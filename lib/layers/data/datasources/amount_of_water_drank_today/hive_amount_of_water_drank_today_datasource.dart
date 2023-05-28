import 'package:hive/hive.dart';

import '../../../../core/utils/constants/constants.dart';
import 'amount_of_water_drank_today_datasource.dart';

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
  Future<int> get() {
    return _hiveInterface.box(WATER_DATA).get(AMOUNT_OF_WATER_DRANK_TODAY);
  }

  @override
  Future<int> subtract(int amount) {
    // TODO: implement subtract
    throw UnimplementedError();
  }

  @override
  Future<int> update(int amount) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
