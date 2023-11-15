import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
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
import 'hive_initializer.dart';

class GetItInitializer {
  final GetIt _getIt;

  GetItInitializer(this._getIt);

  void initialize() {
    _getIt.registerLazySingleton<HiveInterface>(() {
      return Hive;
    });

    _getIt.registerLazySingletonAsync<HiveInitializer>(() async {
      return HiveInitializer(_getIt(), _getIt(), _getIt());
    });

    _getIt.registerLazySingleton<AwesomeNotifications>(() {
      return AwesomeNotifications();
    });

    // Datasources
    _getIt.registerLazySingleton<UserDataSource>(() {
      return HiveUserDataSource(_getIt());
    });

    _getIt.registerLazySingleton<WaterDataSource>(() {
      return HiveWaterDataSource(_getIt());
    });

    _getIt.registerLazySingleton<WaterContainerDataSource>(() {
      return HiveWaterContainerDataSource(_getIt());
    });

    _getIt.registerLazySingleton<DrinkHistoryDataSource>(() {
      return HiveDrinkHistoryDataSource(_getIt());
    });

    // Repositories

    _getIt.registerLazySingleton<WaterRepository>(() {
      return WaterRepositoryImp(_getIt());
    });

    _getIt.registerLazySingleton<WaterContainerRepository>(() {
      return WaterContainerRepositoryImp(_getIt());
    });

    _getIt.registerLazySingleton<UserRepository>(() {
      return UserRepositoryImp(_getIt());
    });

    _getIt.registerLazySingleton<DrinkHistoryRepository>(() {
      return DrinkHistoryRepositoryImp(_getIt());
    });

    // Usecases

    _getIt.registerLazySingleton<CalculateWaterDataUseCase>(() {
      return CalculateWaterDataUseCaseImp(_getIt(), _getIt());
    });

    _getIt.registerLazySingleton<CalculateWaterDataByParametersUseCase>(() {
      return CalculateWaterDataByParametersUseCaseImp();
    });

    _getIt.registerLazySingleton<ValidateSessionUseCase>(() {
      return ValidateSessionUseCaseImp(_getIt(), _getIt());
    });

    _getIt.registerLazySingleton<HandleResetWaterDataUseCase>(() {
      return HandleResetWaterDataUseCaseImp(_getIt());
    });

    // Services

    _getIt.registerLazySingleton<CheckDataForChangesService>(() {
      return CheckDataForChangesServiceImp(_getIt(), _getIt());
    });

    _getIt.registerLazySingleton<TimeToDrinkAgainService>(() {
      return TimeToDrinkAgainServiceImp(_getIt());
    });

    _getIt.registerLazySingleton<TimerToDrinkService>(() {
      return TimerToDrinkServiceImp(_getIt());
    });

    _getIt.registerLazySingleton<ResetDataWithTimerService>(() {
      return ResetDataWithTimerServiceImp(_getIt());
    });

    _getIt.registerLazySingleton<WaterCalculatorService>(() {
      return WaterCalculatorServiceImp();
    });

    _getIt.registerLazySingleton<WaterCalculatorByRepositoryService>(() {
      return WaterCalculatorByRepositoryServiceImp(_getIt(), _getIt());
    });

    _getIt.registerLazySingletonAsync<NotificationService>(() async {
      return NotificationService(_getIt(), _getIt(), _getIt());
    });

    _getIt.registerLazySingleton<WaterContainerGeneratorService>(() {
      return WaterContainerGeneratorServiceImp(_getIt());
    });

    // Controllers

    _getIt.registerLazySingleton<WaterFormController>(() {
      return WaterFormController(_getIt(), _getIt(), _getIt());
    });

    _getIt.registerLazySingleton<WaterController>(() {
      return WaterController(_getIt(), _getIt(), _getIt());
    });

    _getIt.registerLazySingleton<WaterContainerController>(() {
      return WaterContainerController(_getIt(), _getIt());
    });

    _getIt.registerLazySingleton<WaterSettingsController>(() {
      return WaterSettingsController(_getIt(), _getIt(), _getIt(), _getIt());
    });

    _getIt.registerLazySingleton<HomeController>(() {
      return HomeController();
    });

    _getIt.registerLazySingleton<ReminderController>(() {
      return ReminderController(_getIt());
    });

    _getIt.registerLazySingleton<DrinkHistoryController>(() {
      return DrinkHistoryController(_getIt(), _getIt());
    });
  }
}
