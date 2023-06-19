import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../layers/data/datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';
import '../../../layers/data/datasources/amount_of_water_drank_today/hive_amount_of_water_drank_today_datasource.dart';
import '../../../layers/data/datasources/daily_goal/daily_goal_datasource.dart';
import '../../../layers/data/datasources/daily_goal/hive_daily_goal_datasource_imp.dart';
import '../../../layers/data/datasources/times_to_drink_per_day_datasource.dart';
import '../../../layers/data/datasources/water_container/hive_water_container_datasource_imp.dart';
import '../../../layers/data/datasources/water_container/water_container_datasource.dart';
import '../../../layers/data/dtos/water_container/water_container_dto.dart';
import '../../../layers/data/repositories/amount_of_water_drank_today_repository_imp.dart';
import '../../../layers/data/repositories/daily_drinking_frequency_repository_imp.dart';
import '../../../layers/data/repositories/daily_goal_repository_imp.dart';
import '../../../layers/data/repositories/water_container_repository_imp.dart';
import '../../../layers/domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../../layers/domain/repositories/daily_drinking_frequency_repository.dart';
import '../../../layers/domain/repositories/daily_goal_repository.dart';
import '../../../layers/domain/repositories/water_container_repository.dart';
import '../../../layers/presentation/view_models/user_view_model.dart';
import '../../../layers/presentation/view_models/view_stage_view_model.dart';
import '../../../layers/presentation/view_models/water_display_view_model.dart';
import '../../core.dart';
import '../injection/registerers/register_factory.dart';
import '../injection/registerers/register_lazy_singleton_imp.dart';
import 'init_get_it.dart';

Future<void> initApp() async {
  initGetIt([
    RegisterLazySingletonImp<HiveInterface>(() => Hive),
    RegisterLazySingletonImp<WaterContainerDataSource>(
      () => HiveWaterContainerDataSourceImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<DailyGoalDataSource>(
      () => HiveDailyGoalDataSource(GetIt.I()),
    ),
    RegisterLazySingletonImp<AmountOfWaterDrankTodayDataSource>(
      () => HiveAmountOfWaterDrankTodayDataSourceImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<TimesToDrinkPerDayDataSource>(
      () => HiveTimesToDrinkPerDayDataSourceImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<WaterContainerRepository>(
      () => WaterContainerRepositoryImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<DailyGoalRepository>(
      () => DailyGoalRepositoryImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<AmountOfWaterDrankTodayRepository>(
      () => AmountOfWaterDrankTodayRepositoryImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<TimesToDrinkPerDayRepository>(
      () => TimesToDrinkPerDayRepositoryImp(GetIt.I()),
    ),
    RegisterLazySingletonImp<WaterDisplayViewModel>(
      () => WaterDisplayViewModel(GetIt.I(), GetIt.I(), GetIt.I()),
    ),
    RegisterLazySingletonImp<UserViewModel>(
      () => UserViewModel(),
    ),
    RegisterFactoryImp<ViewStageViewModel>(
      () => ViewStageViewModel(FIRST, numberOfStages: NUMBER_OF_STAGES),
    ),
  ]);

  // Hive
  var myHive = MyHive(GetIt.I.get<HiveInterface>());

  myHive.init(await getApplicationDocumentsDirectory().then((directory) => directory.path));

  await myHive.openBoxes([
    WATER_CONTAINER,
    WATER_DATA,
    USER_DATA,
  ]);

  myHive.registerAdapters([WaterContainerDtoAdapter()]);
}
