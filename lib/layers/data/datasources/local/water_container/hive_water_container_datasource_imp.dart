import 'package:hive/hive.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../domain/entities/water_container_entity.dart';
import '../../../dtos/water_container_dto.dart';
import 'water_container_local_datasource.dart';

class HiveWaterContainerDataSourceImp implements WaterContainerLocalDataSource {
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
}
