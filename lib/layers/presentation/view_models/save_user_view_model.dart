import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/validate_user_entity_usecase.dart';

class SaveUserEntityViewModel {
  final UserRepository _userRepository;
  final ValidateUserEntityUseCase _validateUserEntityUseCase;

  SaveUserEntityViewModel(this._userRepository, this._validateUserEntityUseCase);

  Future<Result<void>> updateWeight(double weight) {
    return _userRepository.updateWeight(weight);
  }

  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) {
    return _userRepository.updateSleepTime(sleepTime);
  }

  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) {
    return _userRepository.updateWakeUpTime(wakeUpTime);
  }

  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
    return _userRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays);
  }
}
