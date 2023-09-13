import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/theme/themes.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/services/check_data_for_changes_service.dart';
import '../../domain/usecases/calculate_water_data_by_parameters_usecase.dart';
import '../../domain/usecases/calculate_water_data_usecase.dart';
import '../utils/dialogs.dart';
import '../utils/snackbar_message.dart';

class WaterSettingsController extends ChangeNotifier {
  final WaterRepository _waterRepository;
  final UserRepository _userRepository;
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;
  final CalculateWaterDataByParametersUseCase _calculateWaterDataByParametersUseCase;
  final CheckDataForChangesService _checkDataForChangesService;

  WaterSettingsController(
    this._waterRepository,
    this._userRepository,
    this._calculateWaterDataUseCase,
    this._checkDataForChangesService,
    this._calculateWaterDataByParametersUseCase,
  );

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

  void setDailyGoal(int value) {
    waterDataEntity.dailyGoal = value;

    notifyListeners();
  }

  Future<void> saveData(BuildContext context) async {
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
      await _handleWeightAndWeeklyWorkoutDaysChanges(context);
    } else {
      var setDailyGoalResult = await getResult(
        _waterRepository.setDailyDrinkingGoal(waterDataEntity.dailyGoal),
      );

      if (setDailyGoalResult is Failure) {
        return SnackBarMessage.error(setDailyGoalResult, context: context);
      }
    }

    // if (hasDailyDrinkingFrequencyChanges || hasSleepHabitChanges) {
    await _handleDailyFrequencyAndSleepHabitChanges(context);
    // }
  }

  Future<void> _handleDailyFrequencyAndSleepHabitChanges(BuildContext context) async {
    var setDailyDrinkingFrequencyResult = await getResult(
      _waterRepository.setDailyFrequency(waterDataEntity.dailyDrinkingFrequency),
    );

    var setSleepHabitResult = await getResult(
      _userRepository.setSleepHabit(userEntity.sleepHabit),
    );

    final WaterDataEntity calculatedWaterData = _calculateWaterDataByParametersUseCase(
      userEntity: userEntity,
      dailyDrinkingFrequency: waterDataEntity.dailyDrinkingFrequency,
    );

    var setTimesToDrink = await getResult(
      _waterRepository.setTimesToDrink(calculatedWaterData.timesToDrink),
    );

    if (setTimesToDrink is Failure) {
      return SnackBarMessage.error(setTimesToDrink, context: context);
    }

    if (setDailyDrinkingFrequencyResult is Failure) {
      return SnackBarMessage.error(setDailyDrinkingFrequencyResult, context: context);
    }

    if (setSleepHabitResult is Failure) {
      return SnackBarMessage.error(setSleepHabitResult, context: context);
    }
  }

  Future<void> _handleWeightAndWeeklyWorkoutDaysChanges(BuildContext context) async {
    var isDailyGoalCustomResult = await getResult(
      _checkDataForChangesService.isDailyGoalCustom(waterDataEntity.dailyGoal),
    );

    var setWeightResult = await getResult(
      _userRepository.setWeight(userEntity.weight),
    );

    var setWeeklyWorkoutDays = await getResult(
      _userRepository.setWeeklyWorkoutDays(userEntity.weeklyWorkoutDays),
    );

    if (setWeightResult is Failure) {
      return SnackBarMessage.error(setWeightResult, context: context);
    }

    if (setWeeklyWorkoutDays is Failure) {
      return SnackBarMessage.error(setWeeklyWorkoutDays, context: context);
    }

    if (isDailyGoalCustomResult is Failure) {
      return SnackBarMessage.error(isDailyGoalCustomResult, context: context);
    }

    final WaterDataEntity calculatedWaterData = _calculateWaterDataByParametersUseCase(
      userEntity: userEntity,
      dailyDrinkingFrequency: waterDataEntity.dailyDrinkingFrequency,
    );

    final isDailyGoalCustom = isDailyGoalCustomResult as bool;

    if (isDailyGoalCustom) {
      await Dialogs.confirmCustom(
        title: 'Redefinir meta diária?',
        text: 'Parece que a meta diária é customizada. Deseja redefini-la com base nos novos dados?',
        actions: SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () {},
                    child: CupertinoButton(
                      pressedOpacity: null,
                      onPressed: () async {
                        var setDailyGoalResult = await getResult(
                          _waterRepository.setDailyDrinkingGoal(waterDataEntity.dailyGoal),
                        );

                        if (setDailyGoalResult is Failure) {
                          SnackBarMessage.normal(text: 'Não foi possível definir meta diária', context: context);
                        }

                        Navigator.pop(context);
                      },
                      child: const Text('Não, manter customizada'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Spacing.small),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: CupertinoButton(
                    pressedOpacity: null,
                    onPressed: () async {
                      var setDailyGoalResult = await getResult(
                        _waterRepository.setDailyDrinkingGoal(calculatedWaterData.dailyGoal),
                      );

                      Navigator.pop(context);

                      if (setDailyGoalResult is Failure) {
                        return SnackBarMessage.error(setDailyGoalResult, context: context);
                      }
                    },
                    child: const Align(
                      child: Text('Sim, redefinir'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        context: context,
      );
    } else {
      var setDailyDrinkingGoalResult = await getResult(
        _waterRepository.setDailyDrinkingGoal(calculatedWaterData.dailyGoal),
      );

      if (setDailyDrinkingGoalResult is Failure) {
        return SnackBarMessage.error(setDailyDrinkingGoalResult, context: context);
      }
    }
  }

  // Future<void> saveData() async {
  //   final setUserResult = await getResult(_userRepository.setUser(userEntity));

  //   final dailyDrinkingFrequencyResult = await getResult(
  //     _waterRepository.setDailyFrequency(waterDataEntity.dailyDrinkingFrequency),
  //   );

  //   if (setUserResult is Failure) throw Exception();

  //   if (dailyDrinkingFrequencyResult is Failure) throw Exception();

  //   final calculateWaterDataResult = await getResult(_calculateWaterDataUseCase());
  //   if (calculateWaterDataResult is Failure) throw Exception();

  //   WaterDataEntity calculatedWaterDataEntity = calculateWaterDataResult;

  //   final setWaterDataResult = await getResult(_waterRepository.setWaterData(calculatedWaterDataEntity));
  //   if (setWaterDataResult is Failure) throw Exception();

  //   return;
  // }
}
