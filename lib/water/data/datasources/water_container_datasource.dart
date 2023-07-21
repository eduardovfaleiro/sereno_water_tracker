import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../dtos/water_container/water_container_dto.dart';

abstract interface class WaterContainerDataSource {
  Future<WaterContainerDto> get(int id);
  Future<void> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(int id);
  Future<void> update(WaterContainerDto waterContainerDto);
  Future<List<WaterContainerEntity>> getAllContainers();
}

class HiveWaterContainerDataSourceImp implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;

  HiveWaterContainerDataSourceImp(this._hiveInterface);

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    var waterContainerDto = WaterContainerDto.fromEntity(waterContainerEntity);

    return _hiveInterface.box(WATER_CONTAINER).add(waterContainerDto);
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
  Future<List<WaterContainerEntity>> getAllContainers() async {
    var waterContainersDto = _hiveInterface.box(WATER_CONTAINER).values.toList();
    var waterContainersEntities = waterContainersDto.map<WaterContainerEntity>((e) => e.toEntity()).toList();

    return waterContainersEntities;
  }

  // TODO: test
  @override
  Future<void> update(WaterContainerEntity waterContainerDto) {
    throw UnimplementedError();
    // return _hiveInterface.box(WATER_CONTAINER).put(waterContainerDto.id, waterContainerDto);
  }
}
