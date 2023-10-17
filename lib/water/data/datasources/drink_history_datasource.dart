import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/core.dart';
import '../../domain/entities/drink_record_entity.dart';

abstract class DrinkHistoryDataSource {
  Future<void> add(DrinkRecordEntity drinkRecordEntity);

  Future<void> remove(DrinkRecordEntity drinkRecordEntity);
  Future<void> removeAll();
}

class HiveDrinkHistoryDataSource implements DrinkHistoryDataSource {
  final HiveInterface _hive;

  HiveDrinkHistoryDataSource(this._hive);

  @override
  Future<void> add(DrinkRecordEntity drinkRecordEntity) {
    return _hive.box(DRINK_HISTORY).add(drinkRecordEntity);
  }

  @override
  Future<void> remove(DrinkRecordEntity drinkRecordEntity) {
    int index = _hive.box(DRINK_HISTORY).values.toList().indexOf(drinkRecordEntity);

    return _hive.box(DRINK_HISTORY).deleteAt(index);
  }

  @override
  Future<void> removeAll() {
    return _hive.box(DRINK_HISTORY).clear();
  }
}
