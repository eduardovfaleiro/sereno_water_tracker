import 'package:hive/hive.dart';
import '../../water/data/datasources/user_datasource.dart';
import '../../water/data/datasources/water_datasource.dart';
import '../../water/data/repositories/user_repository.dart';
import '../../water/data/repositories/water_repository.dart';
import '../../water/domain/services/time_to_drink_service.dart';
import '../../water/domain/usecases/calculate_water_data_usecase.dart';
import '../../water/domain/usecases/validate_session_usecase.dart';
import '../../water/presentation/controllers/water_controller.dart';
import '../../water/presentation/controllers/water_form_controller.dart';
import '../core.dart';

void initGetIt() {
  // Hive
  getIt.registerLazySingleton<HiveInterface>(() {
    return Hive;
  });

  // Data sources

  getIt.registerLazySingleton<UserDataSource>(() {
    return HiveUserDataSource(getIt());
  });

  getIt.registerLazySingleton<WaterDataSource>(() {
    return HiveWaterDataSource(getIt());
  });

  // Repositories

  getIt.registerLazySingleton<WaterRepository>(() {
    return WaterRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<UserRepository>(() {
    return UserRepositoryImp(getIt());
  });

  // Usecases

  getIt.registerLazySingleton<CalculateWaterDataUseCase>(() {
    return CalculateWaterDataUseCaseImp(getIt(), getIt());
  });

  getIt.registerLazySingleton<ValidateSessionUseCase>(() {
    return ValidateSessionUseCaseImp(getIt(), getIt());
  });

  // Services

  getIt.registerLazySingleton<TimeToDrinkAgainServiceImp>(() {
    return TimeToDrinkAgainServiceImp(getIt());
  });

  // Controllers

  getIt.registerLazySingleton<WaterFormController>(() {
    return WaterFormController(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterController>(() {
    return WaterController(getIt(), getIt());
  });
}
