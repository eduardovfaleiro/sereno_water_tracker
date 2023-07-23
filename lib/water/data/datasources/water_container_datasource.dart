import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import '../../domain/usecases/converters/convert_water_container_entity_to_dto_usecase.dart';
import '../dtos/water_container/water_container_dto.dart';

abstract interface class WaterContainerDataSource {
  Future<WaterContainerEntity> get(int id);
  Future<void> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(int id);
  Future<void> update(WaterContainerEntity waterContainerEntity);
  Future<List<WaterContainerEntity>> getAllContainers();
}

class HiveWaterContainerDataSourceImp implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;
  final ConvertWaterContainerEntityToDtoUseCase _convertWaterContainerEntityToDtoUseCase;
  final ConvertWaterContainerDtoToEntityUseCase _convertWaterContainerDtoToEntityUseCase;

  HiveWaterContainerDataSourceImp(
    this._hiveInterface,
    this._convertWaterContainerEntityToDtoUseCase,
    this._convertWaterContainerDtoToEntityUseCase,
  );

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    WaterContainerDto waterContainerDto = _convertWaterContainerEntityToDtoUseCase(waterContainerEntity);

    return _hiveInterface.box(WATER_CONTAINER).add(waterContainerDto);
  }

  @override
  Future<void> delete(int id) {
    return _hiveInterface.box(WATER_CONTAINER).delete(id);
  }

  @override
  Future<WaterContainerEntity> get(int id) async {
    WaterContainerEntity waterContainerEntity = _convertWaterContainerDtoToEntityUseCase(
      _hiveInterface.box(WATER_CONTAINER).getAt(id),
    );

    return waterContainerEntity;
  }

  @override
  Future<List<WaterContainerEntity>> getAllContainers() async {
    var waterContainersDto = _hiveInterface.box(WATER_CONTAINER).values.toList();
    var waterContainersEntities = waterContainersDto.map<WaterContainerEntity>((e) {
      return _convertWaterContainerDtoToEntityUseCase(e);
    }).toList();

    return waterContainersEntities;
  }

  // TODO: test
  @override
  Future<void> update(WaterContainerEntity waterContainerEntity) {
    throw UnimplementedError();
    // return _hiveInterface.box(WATER_CONTAINER).put(waterContainerDto.id, waterContainerDto);
  }
}
