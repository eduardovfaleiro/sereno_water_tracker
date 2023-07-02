import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

abstract interface class SaveUserViewModel {
  Future<Result<void>> updateWeight(double value);
  Future<Result<void>> updateSleepTime(TimeOfDay value);
  Future<Result<void>> updateWakeUpTime(TimeOfDay value);
  Future<Result<void>> updateWeeklyWorkoutDays(int value);
  Future<Result<void>> updateUser(UserEntity value);
}

class SaveUserViewModelImp implements SaveUserViewModel {
  final UserRepository _userRepository;

  SaveUserViewModelImp(this._userRepository);

  @override
  Future<Result<void>> updateWeight(double weight) {
    return _userRepository.updateWeight(weight);
  }

  @override
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) {
    return _userRepository.updateSleepTime(sleepTime);
  }

  @override
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) {
    return _userRepository.updateWakeUpTime(wakeUpTime);
  }

  @override
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    return _userRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays);
  }

  @override
  Future<Result<void>> updateUser(UserEntity value) {
    throw UnimplementedError();
  }
}
