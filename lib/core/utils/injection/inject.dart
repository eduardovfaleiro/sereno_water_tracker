import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../layers/data/datasources/water_container/hive_water_container_datasource_imp.dart';
import '../../../layers/data/datasources/water_container/water_container_datasource.dart';
import '../../../layers/data/repositories/water_container_repository_imp.dart';
import '../../../layers/domain/repositories/water_container_repository.dart';
import '../../../layers/presentation/controllers/water_display_controller.dart';

class Inject {
  static void init() {
    var getIt = GetIt.instance;

    // Hive
    getIt.registerLazySingleton<HiveInterface>(() => Hive);

    // Datasources
    getIt.registerLazySingleton<WaterContainerDataSource>(
      () => HiveWaterContainerDataSourceImp(Hive),
    );

    // Repositories
    getIt.registerLazySingleton<WaterContainerRepository>(
      () => WaterContainerRepositoryImp(getIt()),
    );

    // Controllers
    getIt.registerFactory<WaterDisplayController>(
      () => WaterDisplayController(getIt(), getIt()),
    );
  }
}
