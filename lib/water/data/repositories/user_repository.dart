import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/sleep_habit_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/user_datasource.dart';

abstract class UserRepository {
  Future<Result<void>> setWeight(int value);
  Future<Result<void>> setSleeptime(TimeOfDay value);
  Future<Result<void>> setWakeUpTime(TimeOfDay value);
  Future<Result<void>> setWeeklyWorkoutDays(int value);
  Future<Result<void>> setSleepHabit(SleepHabitEntity value);
  Future<Result<void>> setUser(UserEntity value);

  //============================================================================

  Future<Result<int>> getWeight();
  Future<Result<TimeOfDay>> getSleeptime();
  Future<Result<TimeOfDay>> getWakeUpTime();
  Future<Result<int>> getWeeklyWorkoutDays();
  Future<Result<SleepHabitEntity>> getSleepHabit();
  Future<Result<UserEntity>> getUser();
}

class UserRepositoryImp implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImp(this._userDataSource);

  // TODO: test
  @override
  Future<Result<int>> getWeight() async {
    return Right(await _userDataSource.getWeight());
  }

  // TODO: test
  @override
  Future<Result<int>> getWeeklyWorkoutDays() async {
    return Right(await _userDataSource.getWeeklyWorkoutDays());
  }

  @override
  Future<Result<TimeOfDay>> getSleeptime() async {
    return Right(await _userDataSource.getSleeptime());
  }

  @override
  Future<Result<TimeOfDay>> getWakeUpTime() async {
    return Right(await _userDataSource.getWakeUpTime());
  }

  @override
  Future<Result<SleepHabitEntity>> getSleepHabit() async {
    return Right(await _userDataSource.getSleepHabit());
  }

  //============================================================================

  @override
  Future<Result<void>> setSleeptime(TimeOfDay sleeptime) async {
    return Right(await _userDataSource.setSleeptime(sleeptime));
  }

  @override
  Future<Result<void>> setWakeUpTime(TimeOfDay wakeUpTime) async {
    return Right(await _userDataSource.setWakeUpTime(wakeUpTime));
  }

  @override
  Future<Result<void>> setWeeklyWorkoutDays(int weeklyWorkoutDays) async {
    return Right(await _userDataSource.setWeeklyWorkoutDays(weeklyWorkoutDays));
  }

  @override
  Future<Result<void>> setWeight(int weight) async {
    return Right(await _userDataSource.setWeight(weight));
  }

  @override
  Future<Result<void>> setSleepHabit(SleepHabitEntity value) async {
    return Right(await _userDataSource.setSleepHabit(value));
  }

  @override
  Future<Result<void>> setUser(UserEntity value) async {
    await _userDataSource.setSleepHabit(value.sleepHabit);
    await _userDataSource.setWeeklyWorkoutDays(value.weeklyWorkoutDays);
    await _userDataSource.setWeight(value.weight);

    return const Right(null);
  }

  @override
  Future<Result<UserEntity>> getUser() async {
    SleepHabitEntity sleepHabit = await _userDataSource.getSleepHabit();
    int weeklyWorkoutDays = await _userDataSource.getWeeklyWorkoutDays();
    int weight = await _userDataSource.getWeight();

    final userEntity = UserEntity(
      weight: weight,
      weeklyWorkoutDays: weeklyWorkoutDays,
      sleeptime: sleepHabit.sleeptime,
      wakeUpTime: sleepHabit.wakeUpTime,
    );

    return Right(userEntity);
  }
}
