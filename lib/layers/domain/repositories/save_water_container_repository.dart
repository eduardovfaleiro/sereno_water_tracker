import '../entities/water_container_entity.dart';

abstract class SaveWaterContainerRepository {
  Future<int> call(WaterContainerEntity waterContainerEntity);
}
