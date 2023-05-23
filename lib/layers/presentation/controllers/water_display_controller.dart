import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';

class WaterDisplayController {
  final WaterContainerRepository _waterContainerRepository;

  WaterDisplayController(this._waterContainerRepository);

  Future<int> createWaterContainer(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.create(waterContainerEntity);
  }

  Future<void> deleteWaterContainer(int id) {
    return _waterContainerRepository.delete(id);
  }
}
