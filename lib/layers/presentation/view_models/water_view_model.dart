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

  Future<Result<void>> updateAmountDrankToday();
  Future<Result<void>> updateDailyDrinkingGoal();
  Future<Result<void>> updateNumberOfTimesToDrinkDaily();
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
    var result = _amountOfWaterDrankTodayRepository.get();

    notifyListeners();
    return result;
  }

  @override
  Future<Result<int>> getNumberOfTimesToDrinkDaily() {
    var result = _numberOfTimesToDrinkWaterDailyRepository.get();

    notifyListeners();
    return result;
  }

  @override
  Future<Result<int>> getDailyDrinkingGoal() {
    var result = _dailyDrinkingGoalRepository.get();

    notifyListeners();
    return result;
  }

  @override
  Future<Result<double>> getDailyGoalCompletedPercentage() {
    var result = _getDailyDrinkingGoalCompletedPercentageUseCase();

    notifyListeners();
    return result;
  }

  @override
  Future<Result<void>> updateAmountDrankToday() {
    // TODO: implement updateAmountDrankToday
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateDailyDrinkingGoal() {
    // TODO: implement updateDailyDrinkingGoal
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateNumberOfTimesToDrinkDaily() {
    // TODO: implement updateNumberOfTimesToDrinkDaily
    throw UnimplementedError();
  }
}
