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
  UserEntity? userEntitySavedInInfoPage;

  var waterData = WaterDataEntity.empty().copyWith(
    dailyDrinkingFrequency: DEFAULT_DAILY_DRINKING_FREQUENCY,
  );

  // pages
  final pages = <Widget>[
    const WeightWaterForm(),
    const DailyFrequencyWaterForm(),
    const WeeklyWorkoutDaysWaterForm(),
    const SleepHabitWaterForm(),
  ];

  final pageController = PageController();

  void initFinishPage() {
    waterData = _calculateWaterDataByParametersUseCase(
      userEntity: user,
      dailyDrinkingFrequency: waterData.dailyDrinkingFrequency,
    );
  }

  Future<void> goBack() async {
    await pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutExpo,
    );

    notifyListeners();
  }

  Future<void> goNext() async {
    await pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutExpo,
    );

    notifyListeners();
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

  void setUserEntitySavedInInfoPage(UserEntity userEntity) {
    userEntitySavedInInfoPage = userEntity.copyWith();
  }

  bool checkIfUserEntityHasChanges(UserEntity userEntity) {
    return userEntitySavedInInfoPage != userEntity;
  }

  Result<void> addReminder({
    required BuildContext context,
    required TimeOfDay reminder,
  }) {
    if (waterData.timesToDrink.contains(reminder)) {
      final failure = Failure('Lembrete já existente.');

      SnackBarMessage.error(failure, context: context);
      return Left(failure);
    }

    waterData.timesToDrink.add(reminder);
    return const Right(null);
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

  Future<Result<void>> deleteReminder({
    required BuildContext context,
    required TimeOfDay reminder,
  }) async {
    if (waterData.timesToDrink.length == 1) {
      SnackBarMessage.normal(context: context, text: 'Deve haver ao menos um lembrete.');
      Navigator.pop(context);

      return Left(ReminderCountCannotBeZero('Deve haver ao menos um lembrete.'));
    }

    int index = waterData.timesToDrink.indexOf(reminder);

    if (index == -1) {
      final failure = ReminderNotFoundFailure('Lembrete não encontrado.');

      SnackBarMessage.error(failure, context: context);
      return Left(failure);
    }

    waterData.timesToDrink.remove(reminder);
    notifyListeners();

    SnackBarMessage.undo(
        context: context,
        text: 'Lembrete excluído',
        onPressed: () {
          waterData.timesToDrink.add(reminder);

          notifyListeners();
        });

    return const Right(null);
  }

  Future<Result<void>> saveData() async {
    waterData.dailyDrinkingFrequency = waterData.timesToDrink.length;

    var setUserResult = await getResult(_userRepository.setUser(user));
    var setWaterDataResult = await getResult(_waterRepository.setWaterData(waterData));

    if (setUserResult is Failure) return Left(setUserResult);
    if (setWaterDataResult is Failure) return Left(setWaterDataResult);

    return const Right(null);
  }
}
