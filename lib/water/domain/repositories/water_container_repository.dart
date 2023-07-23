import '../../../core/core.dart';
import '../../data/dtos/water_container/water_container_dto.dart';
import '../entities/water_container_entity.dart';

abstract interface class WaterContainerRepository {
  Future<Result<WaterContainerEntity>> get(int id);
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity);
  Future<Result<void>> delete(int id);
  Future<Result<void>> update(WaterContainerEntity waterContainerEntity);
  Future<Result<List<WaterContainerEntity>>> getAllContainers();
}
