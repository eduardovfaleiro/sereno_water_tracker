import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/services/check_data_for_changes_service.dart';
import '../../domain/usecases/calculate_water_data_usecase.dart';
import '../utils/dialogs.dart';
import '../utils/snackbar_message.dart';

class WaterSettingsController extends ChangeNotifier {
  final WaterRepository _waterRepository;
  final UserRepository _userRepository;
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;
  final CheckDataForChangesService _checkDataForChangesService;

  WaterSettingsController(
      this._waterRepository, this._userRepository, this._calculateWaterDataUseCase, this._checkDataForChangesService);

  late UserEntity userEntity;
  late WaterDataEntity waterDataEntity;

  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;

    userEntity = await getResult(_userRepository.getUser());
    waterDataEntity = await getResult(_waterRepository.getWaterData());

    isLoading = false;

    notifyListeners();
  }

  void setWeight(int value) {
    userEntity.weight = value;

    notifyListeners();
  }

  void setWeeklyWorkoutDays(int value) {
    userEntity.weeklyWorkoutDays = value;

    notifyListeners();
  }

  void setWakeUpTime(TimeOfDay value) {
    userEntity.wakeUpTime = value;

    notifyListeners();
  }

  void setSleepTime(TimeOfDay value) {
    userEntity.sleeptime = value;

    notifyListeners();
  }

  void setDailyDrinkingFrequency(int value) {
    waterDataEntity.dailyDrinkingFrequency = value;

    notifyListeners();
  }

  Future<void> checkAndActOnChanges(BuildContext context) async {
    // Get results
    var checkForWeightChangesResult = await getResult(
      _checkDataForChangesService.weight(userEntity.weight),
    );

    var checkForWeeklyWorkoutDaysResult = await getResult(
      _checkDataForChangesService.weeklyWorkoutDays(userEntity.weeklyWorkoutDays),
    );

    // Failure handling
    if (checkForWeightChangesResult is Failure) {
      return SnackBarMessage.error(checkForWeightChangesResult, context: context);
    }

    if (checkForWeeklyWorkoutDaysResult is Failure) {
      return SnackBarMessage.error(checkForWeeklyWorkoutDaysResult, context: context);
    }

    // Assign
    final hasWeightChanges = checkForWeightChangesResult as bool;
    final hasWeeklyWorkoutDaysChanges = checkForWeeklyWorkoutDaysResult as bool;

    // Act
    if (hasWeightChanges || hasWeeklyWorkoutDaysChanges) {
      var isDailyGoalCustomResult = await getResult(
        _checkDataForChangesService.isDailyGoalCustom(waterDataEntity.dailyGoal),
      );

      if (isDailyGoalCustomResult is Failure) {
        return SnackBarMessage.error(isDailyGoalCustomResult, context: context);
      }

      final isDailyGoalCustom = isDailyGoalCustomResult as bool;

      if (isDailyGoalCustom) {
        await Dialogs.confirm(
          title: 'Redefinir meta diária?',
          text: 'Parece que a meta diária é customizada. Deseja redefini-la com base nos novos dados?',
          onYes: () async {
            var setUserResult = await getResult(_userRepository.setUser(userEntity));

            if (setUserResult is Failure) throw Exception();
          },
          onNo: () async {
            var setWeightResult = await getResult(_userRepository.setWeight(userEntity.weight));

            if (setWeightResult is Failure) throw Exception();

            // TODO: continue from here
          },
          context: context,
        );
      }

      var setUserResult = await getResult(_userRepository.setUser(userEntity));

      if (setUserResult is Failure) {
        return SnackBarMessage.error(setUserResult, context: context);
      }

      // Act
    }
  }

  Future<void> saveData() async {
    final setUserResult = await getResult(_userRepository.setUser(userEntity));

    final dailyDrinkingFrequencyResult = await getResult(
      _waterRepository.setDailyFrequency(waterDataEntity.dailyDrinkingFrequency),
    );

    if (setUserResult is Failure) throw Exception();

    if (dailyDrinkingFrequencyResult is Failure) throw Exception();

    final calculateWaterDataResult = await getResult(_calculateWaterDataUseCase());
    if (calculateWaterDataResult is Failure) throw Exception();

    WaterDataEntity calculatedWaterDataEntity = calculateWaterDataResult;

    final setWaterDataResult = await getResult(_waterRepository.setWaterData(calculatedWaterDataEntity));
    if (setWaterDataResult is Failure) throw Exception();

    return;
  }
}
