import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import '../../domain/usecases/converters/convert_water_container_entity_to_dto_usecase.dart';
import '../dtos/water_container/water_container_dto.dart';
import 'get_all_water_containers_datasource.dart';

abstract interface class WaterContainerDataSource {
  Future<void> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(WaterContainerEntity waterContainerEntity);
  Future<void> update(WaterContainerEntity waterContainerEntity);
  Future<List<WaterContainerEntity>> getAllContainers();
}

class HiveWaterContainerDataSourceImp implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;
  final GetAllWaterContainersDataSource _getAllWaterContainersDataSource;
  final ConvertWaterContainerEntityToDtoUseCase _convertWaterContainerEntityToDtoUseCase;
  final ConvertWaterContainerDtoToEntityUseCase _convertWaterContainerDtoToEntityUseCase;

  HiveWaterContainerDataSourceImp(
    this._hiveInterface,
    this._convertWaterContainerEntityToDtoUseCase,
    this._convertWaterContainerDtoToEntityUseCase,
    this._getAllWaterContainersDataSource,
  );

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    WaterContainerDto waterContainerDto = _convertWaterContainerEntityToDtoUseCase(waterContainerEntity);

    return _hiveInterface.box(WATER_CONTAINER).add(waterContainerDto);
  }

  @override
  Future<void> delete(WaterContainerEntity waterContainerEntity) async {
    List<WaterContainerEntity> waterContainers = await _getAllWaterContainersDataSource();

    int index = () {
      for (int i = 0; i < waterContainers.length; i++) {
        if (waterContainers[i] == waterContainerEntity) return i;
      }

      throw WaterContainerNotFoundException("Couldn't delete waterContainerEntity because it was not found");
    }();

    return _hiveInterface.box(WATER_CONTAINER).deleteAt(index);
  }

  @override
  Future<List<WaterContainerEntity>> getAllContainers() async {
    return _getAllWaterContainersDataSource();
  }

  // TODO: test
  @override
  Future<void> update(WaterContainerEntity waterContainerEntity) async {
    List<WaterContainerEntity> waterContainers = await _getAllWaterContainersDataSource();

    int index = () {
      for (int i = 0; i < waterContainers.length; i++) {
        if (waterContainers[i] == waterContainerEntity) return i;
      }

      throw WaterContainerNotFoundException("Couldn't update waterContainerEntity because it was not found");
    }();

    return _hiveInterface.box(WATER_CONTAINER).put(index, waterContainerEntity);
  }
}
