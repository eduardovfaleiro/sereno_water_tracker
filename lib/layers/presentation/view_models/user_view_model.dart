// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class UserViewModel extends ChangeNotifier {
  final UserEntity _userEntity;

  UserViewModel() : _userEntity = UserEntity();

  double get weight => _userEntity.weight;
  int get timesToDrinkPerDay => _userEntity.timesToDrinkPerDay;
  int get weeklyWorkoutDays => _userEntity.weeklyWorkoutDays;

  void updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    _userEntity.weeklyWorkoutDays = weeklyWorkoutDays;

    notifyListeners();
  }

  void updateTimesToDrinkPerDay(int timesToDrinkPerDay) {
    _userEntity.timesToDrinkPerDay = timesToDrinkPerDay;

    notifyListeners();
  }

  void updateWeight(double weight) {
    _userEntity.weight = weight;

    notifyListeners();
  }
}
