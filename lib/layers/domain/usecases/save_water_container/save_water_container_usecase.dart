import '../../entities/water_container_entity.dart';

abstract class SaveWaterContaineUseCase {
  Future<int> call(WaterContainerEntity waterContainerEntity);
}
