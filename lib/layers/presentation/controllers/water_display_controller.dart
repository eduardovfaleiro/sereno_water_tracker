import '../../domain/usecases/water_container/create_water_container/create_water_container_usecase.dart';
import '../../domain/usecases/water_container/delete_water_container/delete_water_container_usecase.dart';

class WaterDisplayController {
  final CreateWaterContainerUseCase _createWaterContainerUseCase;
  final DeleteWaterContainerUseCase _deleteWaterContainerUseCase;

  WaterDisplayController(
    this._createWaterContainerUseCase,
    this._deleteWaterContainerUseCase,
  );

  Future<void> createWaterContainer() async => await _createWaterContainerUseCase();

  void deleteWaterContainer(int waterContainerEntityIndex) {
    _deleteWaterContainerUseCase(waterContainerEntityIndex);
  }
}
