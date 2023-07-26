import '../../../core/core.dart';
import '../entities/water_container_entity.dart';

abstract interface class WaterContainerRepository {
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity);
  Future<Result<void>> delete(WaterContainerEntity waterContainerEntity);
  Future<Result<void>> update(WaterContainerEntity waterContainerEntity);
  Future<Result<List<WaterContainerEntity>>> getAllContainers();
}
