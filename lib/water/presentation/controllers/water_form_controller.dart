import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/sleep_habit_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/usecases/calculate_water_data_usecase.dart';
import '../utils/snackbar_message.dart';

class WaterFormController extends ChangeNotifier {
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;

  final UserRepository _userRepository;
  final WaterRepository _waterRepository;

  WaterFormController(this._userRepository, this._waterRepository, this._calculateWaterDataUseCase);

  late UserEntity user;
  late int dailyDrinkingFrequency;

  final pageController = PageController();

  Future<void> init({UserEntity? userEntity, int? dailyDrinkingFrequency}) async {
    if (userEntity != null) {
      user = userEntity.copyWith();
    } else {
      final sleepHabitResult = await getResult(
        _userRepository.getSleepHabit(),
      );

      final weightResult = await getResult(
        _userRepository.getWeight(),
      );

      final weeklyWorkoutDaysResult = await getResult(
        _userRepository.getWeeklyWorkoutDays(),
      );

      if (sleepHabitResult is Failure) throw Exception(); // TODO
      if (weightResult is Failure) throw Exception(); // TODO
      if (weeklyWorkoutDaysResult is Failure) throw Exception(); // TODO

      SleepHabitEntity sleepHabit = sleepHabitResult;
      int weight = weightResult;
      int weeklyWorkoutDays = weeklyWorkoutDaysResult;

      user = user.copyWith(
        sleeptime: sleepHabit.sleeptime,
        wakeUpTime: sleepHabit.wakeUpTime,
        weeklyWorkoutDays: weeklyWorkoutDays,
        weight: weight,
      );
    }

    if (dailyDrinkingFrequency != null) {
      this.dailyDrinkingFrequency = dailyDrinkingFrequency;
    } else {
      final dailyDrinkingFrequencyResult = await getResult(
        _waterRepository.getDailyDrinkingFrequency(),
      );

      if (dailyDrinkingFrequencyResult is Failure) throw Exception(); // TODO

      this.dailyDrinkingFrequency = dailyDrinkingFrequencyResult;
    }
  }

  void setWeight(int value) {
    user.weight = value;

    notifyListeners();
  }

  void setDailyDrinkingFrequency(int value) {
    dailyDrinkingFrequency = value;

    notifyListeners();
  }

  void setWeeklyWorkoutDays(int value) {
    user.weeklyWorkoutDays = value;

    notifyListeners();
  }

  void setSleeptime(TimeOfDay value) {
    user.sleeptime = value;

    notifyListeners();
  }

  void setWakeUpTime(TimeOfDay value) {
    user.wakeUpTime = value;

    notifyListeners();
  }

  Future<UserEntity> getUser() async {
    return await getResult(_userRepository.getUser());
  }

  Future<Result<void>> saveData(BuildContext context) async {
    final setUserResult = await getResult(_userRepository.setUser(user));
    final dailyDrinkingFrequencyResult = await getResult(
      _waterRepository.setDailyFrequency(dailyDrinkingFrequency),
    );

    if (setUserResult is Failure) {
      SnackBarMessage.error(setUserResult, context: context);

      return Left(setUserResult);
    }

    if (dailyDrinkingFrequencyResult is Failure) {
      SnackBarMessage.error(dailyDrinkingFrequencyResult, context: context);

      return Left(dailyDrinkingFrequencyResult);
    }

    final calculateWaterDataResult = await getResult(_calculateWaterDataUseCase());
    if (calculateWaterDataResult is Failure) throw Exception();

    WaterDataEntity waterDataEntity = calculateWaterDataResult;

    final setWaterDataResult = await getResult(_waterRepository.setWaterData(waterDataEntity));
    if (setWaterDataResult is Failure) throw Exception();

    return const Right(null);
  }
}
