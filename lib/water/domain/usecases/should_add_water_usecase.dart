// TODO: test

import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_drank_today_repository.dart';
import '../../data/repositories/water_repository.dart';

abstract interface class ShouldAddWaterUseCase {
  Future<Result<bool>> call(int amount);
}

class ShouldAddWaterUseCaseImp implements ShouldAddWaterUseCase {
  final WaterDrankTodayRepository _waterDrankTodayRepository;
  final WaterRepository _waterRepository;

  ShouldAddWaterUseCaseImp(
    this._waterDrankTodayRepository,
    this._waterRepository,
  );

  @override
  Future<Result<bool>> call(int amount) async {
    final amountDrankTodayResult = await getResult(
      _waterDrankTodayRepository.get(),
    );

    final dailyDrinkingGoalResult = await getResult(
      _waterRepository.getDailyDrinkingGoal(),
    );

    if (amountDrankTodayResult is Failure) {
      return Left(amountDrankTodayResult);
    }

    if (dailyDrinkingGoalResult is Failure) {
      return Left(dailyDrinkingGoalResult);
    }

    int amountDrankToday = amountDrankTodayResult;
    int dailyDrinkingGoal = dailyDrinkingGoalResult;

    return Right(amountDrankToday + amount > dailyDrinkingGoal);
  }
}
