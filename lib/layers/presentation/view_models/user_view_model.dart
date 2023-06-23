// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserEntity _userEntity;

  UserViewModel(
    this._userRepository,
    this._userEntity,
  );

  double get weight => _userEntity.weight;
  int get timesToDrinkPerDay => _userEntity.timesToDrinkPerDay;
  int get weeklyWorkoutDays => _userEntity.weeklyWorkoutDays;
  TimeOfDay? get sleepTime => _userEntity.sleepTime;
  TimeOfDay? get wakeUpTime => _userEntity.wakeUpTime;

  void updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    _userEntity = _userEntity.copyWith(weeklyWorkoutDays: weeklyWorkoutDays);

    notifyListeners();
  }

  void updateTimesToDrinkPerDay(int timesToDrinkPerDay) {
    _userEntity = _userEntity.copyWith(timesToDrinkPerDay: timesToDrinkPerDay);

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

  // Future<Result<void>> updateDB() {
  //   // return _userRepository.updateSleepTime(sleepTime)
  // }
}
