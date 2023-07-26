import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import '../dtos/water_container/water_container_dto.dart';

abstract interface class GetAllWaterContainersDataSource {
  Future<List<WaterContainerEntity>> call();
}

class HiveGetAllWaterContainersDataSourceImp implements GetAllWaterContainersDataSource {
  final HiveInterface _hiveInterface;
  final ConvertWaterContainerDtoToEntityUseCase _convertWaterContainerDtoToEntityUseCase;

  HiveGetAllWaterContainersDataSourceImp(this._hiveInterface, this._convertWaterContainerDtoToEntityUseCase);

  @override
  Future<List<WaterContainerEntity>> call() async {
    List<WaterContainerDto> waterContainerDtos = _hiveInterface.box(WATER_CONTAINER).values.cast<WaterContainerDto>().toList();

    List<WaterContainerEntity> waterContainerEntities = waterContainerDtos.map((e) {
      return _convertWaterContainerDtoToEntityUseCase(e);
    }).toList();

    return waterContainerEntities;
  }
}
