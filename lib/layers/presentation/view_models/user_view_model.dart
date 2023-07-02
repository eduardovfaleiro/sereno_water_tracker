// ignore_for_file: public_member_api_docs, sort_constructors_first, void_checks
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class UserEntityViewModel extends ChangeNotifier {
  UserEntity _userEntity;

  UserEntityViewModel(this._userEntity);

  double get weight => _userEntity.weight;
  int get dailyDrinkingFrequency => _userEntity.dailyDrinkingFrequency;
  int get weeklyWorkoutDays => _userEntity.weeklyWorkoutDays;
  TimeOfDay? get sleepTime => _userEntity.sleepTime;
  TimeOfDay? get wakeUpTime => _userEntity.wakeUpTime;
  UserEntity getUserEntity() => _userEntity;

  void updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    _userEntity = _userEntity.copyWith(weeklyWorkoutDays: weeklyWorkoutDays);

    notifyListeners();
  }

  void updateDailyDrinkingFrequency(int dailyDrinkingFrequency) {
    _userEntity = _userEntity.copyWith(dailyDrinkingFrequency: dailyDrinkingFrequency);

    notifyListeners();
  }

  void updateWeight(double weight) {
    _userEntity = _userEntity.copyWith(weight: weight);

    notifyListeners();
  }

  void updateSleepTime(TimeOfDay sleepTime) {
    _userEntity = _userEntity.copyWith(sleepTime: sleepTime);

    notifyListeners();
  }

  void updateWakeUpTime(TimeOfDay wakeUpTime) {
    _userEntity = _userEntity.copyWith(wakeUpTime: wakeUpTime);

    notifyListeners();
  }
}
