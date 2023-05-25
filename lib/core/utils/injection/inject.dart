import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../layers/data/datasources/local/water_container/hive_water_container_datasource_imp.dart';
import '../../../layers/data/datasources/local/water_container/water_container_local_datasource.dart';
import '../../../layers/data/repositories/water_container_repository_imp.dart';
import '../../../layers/domain/repositories/water_container_repository.dart';
import '../../../layers/presentation/controllers/water_display_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    // Datasources
    getIt.registerLazySingleton<WaterContainerLocalDataSource>(
      () => HiveWaterContainerDataSourceImp(Hive),
    );

    // Repositories
    getIt.registerLazySingleton<WaterContainerRepository>(
      () => WaterContainerRepositoryImp(getIt()),
    );

    // Controllers
    getIt.registerFactory<WaterDisplayController>(
      () => WaterDisplayController(getIt()),
    );
  }
}
