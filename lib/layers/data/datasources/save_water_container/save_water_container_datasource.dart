import '../../../domain/entities/water_container_entity.dart';

abstract class SaveWaterContainerDataSource {
  Future<int> call(WaterContainerEntity waterContainerEntity);
}
