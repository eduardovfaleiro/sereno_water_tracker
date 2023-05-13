import 'package:get_it/get_it.dart';

import '../../layers/data/repositories/water_container/delete_water_container_box_repository_imp.dart';
import '../../layers/domain/repositories/water_container/delete_water_container_repository.dart';
import '../../layers/domain/usecases/water_container/delete_water_container/delete_water_container_usecase.dart';
import '../../layers/domain/usecases/water_container/delete_water_container/delete_water_container_usecase_imp.dart';
import '../../layers/presentation/controllers/water_display_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    // Repositories
    getIt.registerLazySingleton<DeleteWaterContainerRepository>(
      () => DeleteWaterContainerRepositoryImp(),
    );

    // Usecases
    getIt.registerLazySingleton<DeleteWaterContainerUseCase>(
      () => DeleteWaterContainerUseCaseImp(getIt()),
    );

    // Controllers
    getIt.registerFactory<WaterDisplayController>(
      () => WaterDisplayController(getIt(), getIt()),
    );
  }
}
