import 'package:hive/hive.dart';

import '../../../core/core.dart';

abstract interface class WeightDataSource {
  Future<double> get();
  Future<void> update(double weight);
}

class HiveWeightDataSourceImp implements WeightDataSource {
  final HiveInterface _hiveInterface;

  HiveWeightDataSourceImp(this._hiveInterface);

  @override
  Future<double> get() async {
    return _hiveInterface.box(USER_DATA).get(WEIGHT);
  }

  @override
  Future<void> update(double weight) {
    return _hiveInterface.box(USER_DATA).put(WEIGHT, weight);
  }
}
