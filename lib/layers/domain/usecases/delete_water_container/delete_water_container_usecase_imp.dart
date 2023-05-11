import '../../repositories/delete_water_container_repository.dart';
import 'delete_water_container_usecase.dart';

class DeleteWaterContainerUseCaseImp implements DeleteWaterContainerUseCase {
  final DeleteWaterContainerRepository _deleteWaterContainerRepository;

  DeleteWaterContainerUseCaseImp(this._deleteWaterContainerRepository);

  @override
  void call(int waterContainerEntityIndex) {
    _deleteWaterContainerRepository(waterContainerEntityIndex);
  }
}
