import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class WeightDataSource {
  Future<int> get();
  Future<void> update(int weight);
}

class HiveWeightDataSourceImp implements WeightDataSource {
  final HiveInterface _hiveInterface;

  HiveWeightDataSourceImp(this._hiveInterface);

  @override
  Future<int> get() async {
    return _hiveInterface.box(USER_DATA).get(WEIGHT);
  }

  @override
  Future<void> update(int weight) {
    return _hiveInterface.box(USER_DATA).put(WEIGHT, weight);
  }
}
