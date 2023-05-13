import 'package:hive/hive.dart';

import '../../../domain/entities/water_container_entity.dart';
import '../../../domain/repositories/water_container/create_water_container_repository.dart';

class CreateWaterContainerRepositoryImp implements CreateWaterContainerRepository {
  @override
  Future<Box> call() async {
    return await Hive.openBox<WaterContainerEntity>('waterContainers');
  }
}
