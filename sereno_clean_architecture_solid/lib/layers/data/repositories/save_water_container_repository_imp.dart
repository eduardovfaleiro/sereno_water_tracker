import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/save_water_container_repository.dart';

import '../datasources/save_water_container/save_water_container_datasource.dart';

class SaveWaterContainerRepositoryImp implements SaveWaterContainerRepository {
  final SaveWaterContainerDataSource _saveWaterContainerDataSourceImp;

  SaveWaterContainerRepositoryImp(this._saveWaterContainerDataSourceImp);

  @override
  Future<int> call(WaterContainerEntity waterContainerEntity) async {
    return await _saveWaterContainerDataSourceImp(waterContainerEntity);
  }
}
