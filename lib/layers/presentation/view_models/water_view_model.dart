import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../domain/repositories/daily_drinking_frequency_repository.dart';
import '../../domain/repositories/daily_goal_repository.dart';
import '../../domain/usecases/get_daily_drinking_goal_completion_in_percentage_usecase.dart';

abstract interface class WaterViewModel extends ChangeNotifier {
  Future<Result<int>> getAmountDrankToday();
  Future<Result<int>> getDailyDrinkingGoal();
  Future<Result<int>> getNumberOfTimesToDrinkDaily();
  Future<Result<double>> getDailyGoalCompletedPercentage();

  Future<Result<void>> updateAmountDrankToday(int amount);
  Future<Result<void>> updateDailyDrinkingGoal(int amount);
  Future<Result<void>> updateNumberOfTimesToDrinkDaily(int times);

  Future<Result<void>> initializeData();
}

class WaterViewModelImp extends ChangeNotifier implements WaterViewModel {
  final DailyDrinkingGoalRepository _dailyDrinkingGoalRepository;
  final NumberOfTimesToDrinkWaterDailyRepository _numberOfTimesToDrinkWaterDailyRepository;
  final AmountOfWaterDrankTodayRepository _amountOfWaterDrankTodayRepository;
  final GetDailyDrinkingGoalCompletedPercentageUseCase _getDailyDrinkingGoalCompletedPercentageUseCase;

  WaterViewModelImp(
    this._dailyDrinkingGoalRepository,
    this._numberOfTimesToDrinkWaterDailyRepository,
    this._amountOfWaterDrankTodayRepository,
    this._getDailyDrinkingGoalCompletedPercentageUseCase,
  );

  @override
  Future<Result<int>> getAmountDrankToday() {
    return _amountOfWaterDrankTodayRepository.get();
  }

  @override
  Future<Result<int>> getNumberOfTimesToDrinkDaily() {
    return _numberOfTimesToDrinkWaterDailyRepository.get();
  }

  @override
  Future<Result<int>> getDailyDrinkingGoal() {
    return _dailyDrinkingGoalRepository.get();
  }

  @override
  Future<Result<double>> getDailyGoalCompletedPercentage() {
    return _getDailyDrinkingGoalCompletedPercentageUseCase();
  }

  @override
  Future<Result<void>> updateAmountDrankToday(int amount) {
    return _amountOfWaterDrankTodayRepository.update(amount).whenComplete(() => notifyListeners());
  }

  @override
  Future<Result<void>> updateDailyDrinkingGoal(int amount) {
    return _dailyDrinkingGoalRepository.update(amount).whenComplete(() => notifyListeners());
  }

  @override
  Future<Result<void>> updateNumberOfTimesToDrinkDaily(int times) {
    return _numberOfTimesToDrinkWaterDailyRepository.update(times).whenComplete(() => notifyListeners());
  }

  // TODO: test
  @override
  Future<Result<void>> initializeData() async {
    var amountOfWaterDrankTodayRepositoryResult = await _amountOfWaterDrankTodayRepository.update(MIN_AMOUNT_OF_WATER_DRANK_TODAY);
    if (amountOfWaterDrankTodayRepositoryResult is Left) return amountOfWaterDrankTodayRepositoryResult;

    var numberOfTimesToDrinkWaterDailyRepositoryResult = await _numberOfTimesToDrinkWaterDailyRepository.update(MIN_NUMBER_OF_TIMES_TO_DRINK_A_DAY);
    if (numberOfTimesToDrinkWaterDailyRepositoryResult is Left) return numberOfTimesToDrinkWaterDailyRepositoryResult;

    var dailyDrinkingGoalRepositoryResult = await _dailyDrinkingGoalRepository.update(MIN_DAILY_DRINKING_GOAL);
    if (dailyDrinkingGoalRepositoryResult is Left) return dailyDrinkingGoalRepositoryResult;

    return const Right(null);
  }
}
