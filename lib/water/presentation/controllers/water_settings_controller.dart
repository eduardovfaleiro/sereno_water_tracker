import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';

class WaterSettingsController extends ChangeNotifier {
  final WaterRepository _waterRepository;
  final UserRepository _userRepository;

  WaterSettingsController(this._waterRepository, this._userRepository);

  late UserEntity userEntity;
  late WaterDataEntity waterDataEntity;

  Future<void> init() async {
    userEntity = await getResult(_userRepository.getUser());
    waterDataEntity = await getResult(_waterRepository.getWaterData());
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
    final setWaterDataResult = await getResult(_waterRepository.setWaterData(waterDataEntity));
    final setUserResult = await getResult(_userRepository.setUser(userEntity));

    if (setWaterDataResult is Failure) throw Exception();
    if (setUserResult is Failure) throw Exception();
  }
}
