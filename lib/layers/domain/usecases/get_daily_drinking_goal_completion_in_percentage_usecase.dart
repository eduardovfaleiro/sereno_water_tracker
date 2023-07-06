import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../repositories/amount_of_water_drank_today_repository.dart';
import '../repositories/daily_goal_repository.dart';

abstract interface class GetDailyDrinkingGoalCompletedPercentageUseCase {
  Future<Result<double>> call();
}

class GetDailyDrinkingGoalCompletedPercentageUseCaseImp implements GetDailyDrinkingGoalCompletedPercentageUseCase {
  final DailyDrinkingGoalRepository _dailyDrinkingGoalRepository;
  final AmountOfWaterDrankTodayRepository _amountOfWaterDrankTodayRepository;

  GetDailyDrinkingGoalCompletedPercentageUseCaseImp(
    this._dailyDrinkingGoalRepository,
    this._amountOfWaterDrankTodayRepository,
  );

  @override
  Future<Result<double>> call() async {
    var amountOfWaterDrankTodayResult = await _amountOfWaterDrankTodayRepository.get();
    if (amountOfWaterDrankTodayResult is Left) return Future.value(amountOfWaterDrankTodayResult as FutureOr<Result<double>>?);

    int amountOfWaterDrankToday = amountOfWaterDrankTodayResult.fold((_) {}, (success) => success) as int;

    var dailyDrinkingGoalResult = await _dailyDrinkingGoalRepository.get();
    if (dailyDrinkingGoalResult is Left) return Future.value(dailyDrinkingGoalResult as FutureOr<Result<double>>?);

    int dailyDrinkingGoal = dailyDrinkingGoalResult.fold((_) {}, (success) => success) as int;

    double percentage = amountOfWaterDrankToday / dailyDrinkingGoal;

    return Right(percentage);
  }
}
