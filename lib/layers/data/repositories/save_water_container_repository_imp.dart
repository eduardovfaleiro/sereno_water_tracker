import 'package:hive/hive.dart';

import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/save_water_container_repository.dart';

class SaveWaterContainerRepositoryImp implements SaveWaterContainerRepository {
  @override
  Future<int> call(WaterContainerEntity waterContainerEntity) async {
    return await Hive.box('waterContainers').add(waterContainerEntity);
  }
}
