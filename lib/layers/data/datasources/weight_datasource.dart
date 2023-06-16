import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class WeightDataSource {
  Future<void> update(double weight);
}

class HiveWeightDataSourceImp implements WeightDataSource {
  final HiveInterface _hiveInterface;

  HiveWeightDataSourceImp(this._hiveInterface);

  @override
  Future<void> update(double weight) async {
    await _hiveInterface.box(USER_DATA).put(WEIGHT, weight);
  }
}
