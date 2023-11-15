import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';

import '../../water/data/datasources/drink_history_datasource.dart';
import '../../water/data/datasources/user_datasource.dart';
import '../../water/data/datasources/water_container_datasource.dart';
import '../../water/data/datasources/water_datasource.dart';
import '../../water/data/repositories/drink_history_repository.dart';
import '../../water/data/repositories/user_repository.dart';
import '../../water/data/repositories/water_container_repository.dart';
import '../../water/data/repositories/water_repository.dart';
import '../../water/domain/services/check_data_for_changes_service.dart';
import '../../water/domain/services/notification_service.dart';
import '../../water/domain/services/reset_data_with_timer_service.dart';
import '../../water/domain/services/time_to_drink_service.dart';
import '../../water/domain/services/timer_to_drink_service.dart';
import '../../water/domain/services/water_calculator_by_repository_service.dart';
import '../../water/domain/services/water_calculator_service.dart';
import '../../water/domain/services/water_container_generator_service.dart';
import '../../water/domain/usecases/calculate_water_data_by_parameters_usecase.dart';
import '../../water/domain/usecases/calculate_water_data_usecase.dart';
import '../../water/domain/usecases/handle_reset_water_data_usecase.dart';
import '../../water/domain/usecases/validate_session_usecase.dart';
import '../../water/presentation/controllers/drink_history_controller.dart';
import '../../water/presentation/controllers/home_controller.dart';
import '../../water/presentation/controllers/reminder_controller.dart';
import '../../water/presentation/controllers/water_container_controller.dart';
import '../../water/presentation/controllers/water_controller.dart';
import '../../water/presentation/controllers/water_form_controller.dart';
import '../../water/presentation/controllers/water_settings_controller.dart';
import '../core.dart';
import 'hive_initializer.dart';

void initializeGetIt() {
  getIt.registerLazySingleton<HiveInterface>(() {
    return Hive;
  });

  getIt.registerLazySingleton<HiveInitializer>(() {
    return HiveInitializer(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<AwesomeNotifications>(() {
    return AwesomeNotifications();
  });

  // Datasources

  getIt.registerLazySingleton<UserDataSource>(() {
    return HiveUserDataSource(getIt());
  });

  getIt.registerLazySingleton<WaterDataSource>(() {
    return HiveWaterDataSource(getIt());
  });

  getIt.registerLazySingleton<WaterContainerDataSource>(() {
    return HiveWaterContainerDataSource(getIt());
  });

  getIt.registerLazySingleton<DrinkHistoryDataSource>(() {
    return HiveDrinkHistoryDataSource(getIt());
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

  getIt.registerLazySingleton<DrinkHistoryRepository>(() {
    return DrinkHistoryRepositoryImp(getIt());
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

  // Services

  getIt.registerLazySingleton<CheckDataForChangesService>(() {
    return CheckDataForChangesServiceImp(getIt(), getIt());
  });

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

  getIt.registerLazySingletonAsync<NotificationService>(() async {
    return NotificationService(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterContainerGeneratorService>(() {
    return WaterContainerGeneratorServiceImp(getIt());
  });

  // Controllers

  getIt.registerLazySingleton<WaterFormController>(() {
    return WaterFormController(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterController>(() {
    return WaterController(getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterContainerController>(() {
    return WaterContainerController(getIt(), getIt());
  });

  getIt.registerLazySingleton<WaterSettingsController>(() {
    return WaterSettingsController(getIt(), getIt(), getIt(), getIt());
  });

  getIt.registerLazySingleton<HomeController>(() {
    return HomeController();
  });

  getIt.registerLazySingleton<ReminderController>(() {
    return ReminderController(getIt());
  });

  getIt.registerLazySingleton<DrinkHistoryController>(() {
    return DrinkHistoryController(getIt(), getIt());
  });
}
