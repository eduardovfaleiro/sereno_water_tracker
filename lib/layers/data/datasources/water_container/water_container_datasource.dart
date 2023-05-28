import '../../../domain/entities/water_container_entity.dart';
import '../../dtos/water_container_dto.dart';

abstract interface class WaterContainerDataSource {
  Future<WaterContainerDto> get(int id);
  Future<int> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(int id);
}
