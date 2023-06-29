import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

class UserRepositoryImp implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImp(this._dataSource);

  @override
  Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) async {
    try {
      return Right(await _dataSource.updateSleepTime(sleepTime));
    } catch (error) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) async {
    try {
      return Right(await _dataSource.updateWakeUpTime(wakeUpTime));
    } catch (error) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) async {
    try {
      return Right(await _dataSource.updateWeeklyWorkoutDays(weeklyWorkoutDays));
    } catch (error) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateWeight(double weight) async {
    try {
      return Right(await _dataSource.updateWeight(weight));
    } catch (error) {
      return Left(CacheFailure());
    }
  }
  
  @override
  Future<Result<UserEntity>> getUser() {
    try {
      return Right(await _dataSource.getUser());
    } catch(error) {
      return Left(CacheFailure());
    }
  }

  
  
}
