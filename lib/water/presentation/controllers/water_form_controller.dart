import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/usecases/calculate_water_data_by_parameters_usecase.dart';
import '../../domain/usecases/calculate_water_data_usecase.dart';
import '../utils/snackbar_message.dart';
import '../views/water_form/pages/daily_frequency_water_form.dart';
import '../views/water_form/pages/info_water_form.dart';
import '../views/water_form/pages/sleep_habit_water_form.dart';
import '../views/water_form/pages/weekly_workout_days_water_form.dart';
import '../views/water_form/pages/weight_water_form.dart';

class WaterFormController extends ChangeNotifier {
  final UserRepository _userRepository;
  final WaterRepository _waterRepository;
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;
  final CalculateWaterDataByParametersUseCase _calculateWaterDataByParametersUseCase;

  WaterFormController(
    this._userRepository,
    this._waterRepository,
    this._calculateWaterDataUseCase,
    this._calculateWaterDataByParametersUseCase,
  );

  bool isLoading = false;

  // data
  final user = UserEntity.defaultValues();
  var waterData = WaterDataEntity.empty().copyWith(
    dailyDrinkingFrequency: DEFAULT_DAILY_DRINKING_FREQUENCY,
  );

  // pages
  final pages = <Widget>[
    const WeightWaterForm(),
    const DailyFrequencyWaterForm(),
    const WeeklyWorkoutDaysWaterForm(),
    const SleepHabitWaterForm(),
    const InfoWaterForm(),
  ];

  final pageController = PageController();

  Future<void> init() async {}

  void initInfoPage(BuildContext context) {
    if (waterData.dailyGoal == 0) {
      waterData = _calculateWaterDataByParametersUseCase(
        userEntity: user,
        dailyDrinkingFrequency: waterData.dailyDrinkingFrequency,
      );
    }
  }

  void setWeight(int value) {
    user.weight = value;

    notifyListeners();
  }

  void setDailyDrinkingFrequency(int value) {
    waterData.dailyDrinkingFrequency = value;

    notifyListeners();
  }

  void setWeeklyWorkoutDays(int value) {
    user.weeklyWorkoutDays = value;

    notifyListeners();
  }

  void setSleeptime(TimeOfDay value) {
    user.sleeptime = value;

    notifyListeners();
  }

  void setWakeUpTime(TimeOfDay value) {
    user.wakeUpTime = value;

    notifyListeners();
  }

  void setDailyGoal(int value) {
    waterData.dailyGoal = value;

    notifyListeners();
  }

  Future<UserEntity> getUser() async {
    return await getResult(_userRepository.getUser());
  }

  Result<void> editReminder({
    required BuildContext context,
    required TimeOfDay oldReminder,
    required TimeOfDay newReminder,
  }) {
    int index = waterData.timesToDrink.indexOf(oldReminder);

    if (index == -1) {
      final failure = ReminderNotFoundFailure('Lembrete não encontrado.');

      SnackBarMessage.error(failure, context: context);
      return Left(failure);
    }

    waterData.timesToDrink[index] = newReminder;

    notifyListeners();

    Navigator.pop(context);
    return const Right(null);
  }

  Result<void> deleteReminder({
    required BuildContext context,
    required TimeOfDay reminder,
  }) {
    int index = waterData.timesToDrink.indexOf(reminder);

    if (index == -1) {
      final failure = ReminderNotFoundFailure('Lembrete não encontrado.');

      SnackBarMessage.error(failure, context: context);
      return Left(failure);
    }

    waterData.timesToDrink.remove(reminder);
    return const Right(null);
  }

  Future<Result<void>> saveData(BuildContext context) async {
    var setUserResult = await getResult(_userRepository.setUser(user));
    var dailyDrinkingFrequencyResult =
        await getResult(_waterRepository.setDailyFrequency(waterData.dailyDrinkingFrequency));

    if (setUserResult is Failure) {
      SnackBarMessage.error(setUserResult, context: context);

      return Left(setUserResult);
    }

    if (dailyDrinkingFrequencyResult is Failure) {
      SnackBarMessage.error(dailyDrinkingFrequencyResult, context: context);

      return Left(dailyDrinkingFrequencyResult);
    }

    var calculateWaterDataResult = await getResult(_calculateWaterDataUseCase());
    if (calculateWaterDataResult is Failure) throw Exception();

    WaterDataEntity waterDataEntity = calculateWaterDataResult;

    final setWaterDataResult = await getResult(_waterRepository.setWaterData(waterDataEntity));
    if (setWaterDataResult is Failure) throw Exception();

    return const Right(null);
  }
}
