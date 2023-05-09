import '../../domain/usecases/create_water_container/create_water_container_usecase.dart';
import '../../domain/usecases/delete_water_container/delete_water_container_usecase.dart';

class WaterDisplayController {
  final CreateWaterContainerUseCase createWaterContainer;
  final DeleteWaterContainerUseCase deleteWaterContainerUseCase;

  WaterDisplayController({
    required this.createWaterContainer,
    required this.deleteWaterContainerUseCase,
  });
}
