import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../dtos/water_container/water_container_dto.dart';

abstract interface class WaterContainerDataSource {
  Future<WaterContainerDto> get(int id);
  Future<int> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(int id);
  Future<List<WaterContainerDto>> getAllContainers();
}

class HiveWaterContainerDataSourceImp implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;

  HiveWaterContainerDataSourceImp(this._hiveInterface);

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    return _hiveInterface.box(WATER_CONTAINER).add(waterContainerEntity);
  }

  @override
  Future<void> delete(int id) {
    return _hiveInterface.box(WATER_CONTAINER).delete(id);
  }

  @override
  Future<WaterContainerDto> get(int id) {
    return _hiveInterface.box(WATER_CONTAINER).getAt(id);
  }

  @override
  Future<List<WaterContainerDto>> getAllContainers() async {
    return _hiveInterface.box(WATER_CONTAINER).values.toList() as List<WaterContainerDto>;
  }
}
