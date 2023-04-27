import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';

abstract class SaveWaterContainerRepository {
  Future<int> call(WaterContainerEntity waterContainerEntity);
}
