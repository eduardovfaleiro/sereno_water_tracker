import 'package:hive/hive.dart';
import '../../water/data/datasources/user_datasource.dart';
import '../../water/data/datasources/water_container_datasource.dart';
import '../../water/data/datasources/water_datasource.dart';
import '../../water/data/repositories/user_repository.dart';
import '../../water/data/repositories/water_container_repository.dart';
import '../../water/data/repositories/water_repository.dart';
import '../../water/domain/services/check_data_for_changes_service.dart';
import '../../water/domain/services/reset_data_with_timer_service.dart';
import '../../water/domain/services/time_to_drink_service.dart';
import '../../water/domain/services/timer_to_drink_service.dart';
import '../../water/domain/services/water_calculator_by_repository_service.dart';
import '../../water/domain/services/water_calculator_service.dart';
import '../../water/domain/usecases/calculate_water_data_by_parameters_usecase.dart';
import '../../water/domain/usecases/calculate_water_data_usecase.dart';
import '../../water/domain/usecases/handle_reset_water_data_usecase.dart';
import '../../water/domain/usecases/validate_session_usecase.dart';
import '../../water/presentation/controllers/home_controller.dart';
import '../../water/presentation/controllers/reminder_controller.dart';
import '../../water/presentation/controllers/water_container_controller.dart';
import '../../water/presentation/controllers/water_controller.dart';
import '../../water/presentation/controllers/water_form_controller.dart';
import '../../water/presentation/controllers/water_settings_controller.dart';
import '../core.dart';

Future<void> initGetIt() async {
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

  getIt.registerLazySingleton<WaterContainerDataSource>(() {
    return HiveWaterContainerDataSource(getIt());
  });

  // Repositories

  getIt.registerLazySingleton<WaterRepository>(() {
    return WaterRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<WaterContainerRepository>(() {
    return WaterContainerRepositoryImp(getIt());
  });

  getIt.registerLazySingleton<UserRepository>(() {
    return UserRepositoryImp(getIt());
  });

  // Usecases

  getIt.registerLazySingleton<CalculateWaterDataUseCase>(() {
    return CalculateWaterDataUseCaseImp(getIt(), getIt());
  });

  getIt.registerLazySingleton<CalculateWaterDataByParametersUseCase>(() {
    return CalculateWaterDataByParametersUseCaseImp();
  });

  getIt.registerLazySingleton<ValidateSessionUseCase>(() {
    return ValidateSessionUseCaseImp(getIt(), getIt());
  });

  getIt.registerLazySingleton<HandleResetWaterDataUseCase>(() {
    return HandleResetWaterDataUseCaseImp(getIt());
  });

  getIt.registerLazySingleton<CheckDataForChangesService>(() {
    return CheckDataForChangesServiceImp(getIt(), getIt());
  });

  // Services

  getIt.registerLazySingleton<TimeToDrinkAgainService>(() {
    return TimeToDrinkAgainServiceImp(getIt());
  });

  getIt.registerLazySingleton<TimerToDrinkService>(() {
    return TimerToDrinkServiceImp(getIt());
  });

  getIt.registerLazySingleton<ResetDataWithTimerService>(() {
    return ResetDataWithTimerServiceImp(getIt());
  });

  getIt.registerLazySingleton<WaterCalculatorService>(() {
    return WaterCalculatorServiceImp();
  });

  getIt.registerLazySingleton<WaterCalculatorByRepositoryService>(() {
    return WaterCalculatorByRepositoryServiceImp(getIt(), getIt());
  });

  // ViewModels

  // Controllers

  getIt.registerLazySingleton<WaterFormController>(() {
    return WaterFormController(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterController>(() {
    return WaterController(getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterContainerController>(() {
    return WaterContainerController(getIt());
  });

  getIt.registerLazySingleton<WaterSettingsController>(() {
    return WaterSettingsController(getIt(), getIt(), getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<HomeController>(() {
    return HomeController();
  });

  getIt.registerLazySingleton<ReminderController>(() {
    return ReminderController(getIt());
  });
}
