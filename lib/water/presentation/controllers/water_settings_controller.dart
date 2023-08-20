import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/usecases/calculate_water_data_usecase.dart';

class WaterSettingsController extends ChangeNotifier {
  final WaterRepository _waterRepository;
  final UserRepository _userRepository;
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;

  WaterSettingsController(this._waterRepository, this._userRepository, this._calculateWaterDataUseCase);

  late UserEntity userEntity;
  late WaterDataEntity waterDataEntity;

  bool isDataLoaded = false;

  Future<void> init() async {
    userEntity = await getResult(_userRepository.getUser());
    waterDataEntity = await getResult(_waterRepository.getWaterData());

    isDataLoaded = true;

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
