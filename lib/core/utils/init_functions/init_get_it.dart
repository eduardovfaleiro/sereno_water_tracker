import 'package:hive/hive.dart';

import '../../../layers/data/datasources/amount_of_water_drank_today_datasource.dart';
import '../../../layers/data/datasources/daily_drinking_frequency_datasource.dart';
import '../../../layers/data/datasources/daily_goal_datasource.dart';
import '../../../layers/data/datasources/user_datasource.dart';
import '../../../layers/data/datasources/water_container_datasource.dart';
import '../../../layers/data/repositories/amount_of_water_drank_today_repository_imp.dart';
import '../../../layers/data/repositories/daily_drinking_frequency_repository_imp.dart';
import '../../../layers/data/repositories/daily_goal_repository_imp.dart';
import '../../../layers/data/repositories/user_repository_imp.dart';
import '../../../layers/data/repositories/water_container_repository_imp.dart';
import '../../../layers/domain/entities/user_entity.dart';
import '../../../layers/domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../../layers/domain/repositories/daily_drinking_frequency_repository.dart';
import '../../../layers/domain/repositories/daily_goal_repository.dart';
import '../../../layers/domain/repositories/user_repository.dart';
import '../../../layers/domain/repositories/water_container_repository.dart';
import '../../../layers/domain/usecases/validate_user_entity_usecase.dart';
import '../../../layers/presentation/view_models/user_view_model.dart';
import '../../../layers/presentation/view_models/water_display_view_model.dart';
import '../../core.dart';

void initGetIt() {
  // Hive
  getIt.registerLazySingleton<HiveInterface>(() {
    return Hive;
  });

  // Entities
  getIt.registerLazySingleton<UserEntity>(() {
    return UserEntity();
  });

  // Data sources

  getIt.registerLazySingleton<WaterContainerDataSource>(() {
    return HiveWaterContainerDataSourceImp(getIt());
  });

  getIt.registerLazySingleton<DailyGoalDataSource>(() {
    return HiveDailyGoalDataSource(getIt());
  });

  getIt.registerLazySingleton<AmountOfWaterDrankTodayDataSource>(() {
    return HiveAmountOfWaterDrankTodayDataSourceImp(getIt());
  });

  getIt.registerLazySingleton<DailyDrinkingFrequencyDataSource>(() {
    return HiveDailyDrinkingFrequencyDataSourceImp(getIt());
  });

  getIt.registerLazySingleton<UserDataSource>(() {
    return HiveUserDataSourceImp(getIt());
  });

  // Repositories

  getIt.registerLazySingleton<WaterContainerRepository>(() {
    return WaterContainerRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<DailyGoalRepository>(() {
    return DailyGoalRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<AmountOfWaterDrankTodayRepository>(() {
    return AmountOfWaterDrankTodayRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<DailyDrinkingFrequencyRepository>(() {
    return DailyDrinkingFrequencyRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<UserRepository>(() {
    return UserRepositoryImp(getIt());
  });

  // Usecases
  getIt.registerLazySingleton<ValidateUserEntityUseCase>(() {
    return ValidateUserEntityUseCaseImp();
  });

  // View models

  getIt.registerLazySingleton<WaterDisplayViewModel>(() {
    return WaterDisplayViewModel(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<UserEntityViewModel>(() {
    return UserEntityViewModel(getIt());
  });
}
