// ignore_for_file: public_member_api_docs, sort_constructors_first, void_checks
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/validators/validate_user_entity_usecase.dart';

class UserEntityViewModel extends ChangeNotifier {
  final ValidateUserEntityUseCase _validateUserEntityUseCase;
  UserEntity _userEntity;

  UserEntityViewModel(this._userEntity, this._validateUserEntityUseCase);

  int get weight => _userEntity.weight;
  int get numberOfTimesToDrinkWaterDaily => _userEntity.numberOfTimesToDrinkWaterDaily;
  int get weeklyWorkoutDays => _userEntity.weeklyWorkoutDays;
  TimeOfDay? get sleepTime => _userEntity.sleepTime;
  TimeOfDay? get wakeUpTime => _userEntity.wakeUpTime;
  UserEntity getUserEntity() => _userEntity;

  void updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    _userEntity = _userEntity.copyWith(weeklyWorkoutDays: weeklyWorkoutDays);

    notifyListeners();
  }

  void updateNumberOfTimesToDrinkWaterDaily(int numberOfTimesToDrinkWaterDaily) {
    _userEntity = _userEntity.copyWith(numberOfTimesToDrinkWaterDaily: numberOfTimesToDrinkWaterDaily);

    notifyListeners();
  }

  void updateWeight(int weight) {
    _userEntity = _userEntity.copyWith(weight: weight);

    notifyListeners();
  }

  void updateSleepTime(TimeOfDay? sleepTime) {
    _userEntity = _userEntity.copyWith(sleepTime: sleepTime);

    notifyListeners();
  }

  void updateWakeUpTime(TimeOfDay? wakeUpTime) {
    _userEntity = _userEntity.copyWith(wakeUpTime: wakeUpTime);

    notifyListeners();
  }

  bool get isUserValid => _validateUserEntityUseCase(_userEntity) is Right;
}
