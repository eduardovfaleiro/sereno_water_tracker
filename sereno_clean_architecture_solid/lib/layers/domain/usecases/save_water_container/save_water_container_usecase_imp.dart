import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/save_water_container_repository.dart';

import 'save_water_container_usecase.dart';

class SaveWaterContainerUseCaseImp implements SaveWaterContaineUseCase {
  final SaveWaterContainerRepository _saveWaterContainerRepository;

  SaveWaterContainerUseCaseImp(this._saveWaterContainerRepository);

  @override
  Future<int> call(WaterContainerEntity waterContainerEntity) async {
    return await _saveWaterContainerRepository(waterContainerEntity);
  }
}
