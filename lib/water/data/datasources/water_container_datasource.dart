import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';

abstract class WaterContainerDataSource {
  Future<List<WaterContainerEntity>> getAll();
}

class HiveWaterContainerDataSource implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;

  HiveWaterContainerDataSource(this._hiveInterface);

  @override
  Future<List<WaterContainerEntity>> getAll() async {
    return _hiveInterface.box(WATER_CONTAINER).values.cast<WaterContainerEntity>().toList();
  }
}
