import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/validate_user_entity_usecase.dart';

abstract interface class SaveUserViewModel {
  Future<Result<void>> updateWeight(double value);
  Future<Result<void>> updateSleepTime(TimeOfDay value);
  Future<Result<void>> updateWakeUpTime(TimeOfDay value);
  Future<Result<void>> updateWeeklyWorkoutDays(int value);
  Future<Result<void>> updateUser(UserEntity value);
}

class SaveUserViewModelImp implements SaveUserViewModel {
  final UserRepository _userRepository;
  final ValidateUserEntityUseCase _validateUserEntityUseCase;

  SaveUserViewModelImp(this._userRepository, this._validateUserEntityUseCase);

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
  Future<Result<void>> updateUser(UserEntity userEntity) async {
    var validationResult = _validateUserEntityUseCase(userEntity);
    if (validationResult is Left) return validationResult;

    var updateWeightResult = await _userRepository.updateWeight(userEntity.weight);
    if (updateWeightResult is Left) return updateWeightResult;

    var updateWeeklyWorkoutDaysResult = await _userRepository.updateWeeklyWorkoutDays(userEntity.weeklyWorkoutDays);
    if (updateWeeklyWorkoutDaysResult is Left) return updateWeeklyWorkoutDaysResult;

    var updateWakeUpTime = await _userRepository.updateWakeUpTime(userEntity.wakeUpTime!);
    if (updateWakeUpTime is Left) return updateWakeUpTime;

    var updateSleepTime = await _userRepository.updateSleepTime(userEntity.sleepTime!);
    if (updateSleepTime is Left) return updateSleepTime;

    return const Right(null);
  }
}
