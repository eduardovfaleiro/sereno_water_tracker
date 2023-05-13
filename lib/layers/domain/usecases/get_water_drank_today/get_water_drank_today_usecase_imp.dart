import '../../repositories/get_water_drank_today_repository.dart';
import 'get_water_drank_today_usecase.dart';

class GetWaterDrankTodayUseCaseImp implements GetWaterDrankTodayUseCase {
  final GetWaterDrankTodayRepository _getWaterDrankTodayRepository;

  GetWaterDrankTodayUseCaseImp(this._getWaterDrankTodayRepository);

  @override
  double call() => _getWaterDrankTodayRepository();
}
