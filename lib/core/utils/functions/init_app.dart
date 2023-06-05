import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../layers/data/datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';
import '../../../layers/data/datasources/amount_of_water_drank_today/hive_amount_of_water_drank_today_datasource.dart';
import '../../../layers/data/datasources/water_container/hive_water_container_datasource_imp.dart';
import '../../../layers/data/datasources/water_container/water_container_datasource.dart';
import '../../../layers/data/dtos/water_container/water_container_dto.dart';
import '../../../layers/data/repositories/amount_of_water_drank_today_repository_imp.dart';
import '../../../layers/data/repositories/water_container_repository_imp.dart';
import '../../../layers/domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../../layers/domain/repositories/water_container_repository.dart';
import '../../../layers/presentation/controllers/water_display_controller.dart';
import '../../core.dart';
import '../injection/registerers/register_lazy_singleton_imp.dart';
import 'init_get_it.dart';

Future<void> initApp() async {
  initGetIt([
    RegisterLazySingletonImp<HiveInterface>(() => Hive),
    RegisterLazySingletonImp<WaterContainerDataSource>(() => HiveWaterContainerDataSourceImp(Hive)),
    RegisterLazySingletonImp<AmountOfWaterDrankTodayDataSource>(() => HiveAmountOfWaterDrankTodayDataSourceImp(Hive)),
    RegisterLazySingletonImp<WaterContainerRepository>(() => WaterContainerRepositoryImp(GetIt.I())),
    RegisterLazySingletonImp<AmountOfWaterDrankTodayRepository>(() => AmountOfWaterDrankTodayRepositoryImp(GetIt.I())),
    RegisterLazySingletonImp<WaterDisplayController>(() => WaterDisplayController(GetIt.I(), GetIt.I())),
  ]);

  // Hive
  var myHive = MyHive(GetIt.I.get<HiveInterface>());

  myHive.init(await getApplicationDocumentsDirectory().then((directory) => directory.path));
  await myHive.openBoxes([WATER_CONTAINER, WATER_DATA]);
  myHive.registerAdapters([WaterContainerDtoAdapter()]);
}
