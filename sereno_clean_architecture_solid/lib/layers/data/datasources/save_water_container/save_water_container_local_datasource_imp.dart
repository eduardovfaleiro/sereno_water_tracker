import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';

import 'save_water_container_datasource.dart';

class SaveWaterContainerLocalDataSourceImp implements SaveWaterContainerDataSource {
  @override
  Future<int> call(WaterContainerEntity waterContainerEntity) async {
    return await Hive.box('waterContainers').add(waterContainerEntity);
  }
}
