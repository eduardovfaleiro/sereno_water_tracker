// TODO: test

import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../repositories/amount_of_water_drank_today_repository.dart';
import '../repositories/daily_goal_repository.dart';

abstract interface class ShouldAddWaterUseCase {
  Future<Result<bool>> call(int amount);
}

class ShouldAddWaterUseCaseImp implements ShouldAddWaterUseCase {
  final AmountOfWaterDrankTodayRepository amountOfWaterDrankTodayRepository;
  final DailyDrinkingGoalRepository dailyDrinkingGoalRepository;

  ShouldAddWaterUseCaseImp({
    required this.amountOfWaterDrankTodayRepository,
    required this.dailyDrinkingGoalRepository,
  });

  @override
  Future<Result<bool>> call(int amount) async {
    final amountDrankTodayResult = await amountOfWaterDrankTodayRepository.get();
    final dailyDrinkingGoalResult = await dailyDrinkingGoalRepository.get();

    if (amountDrankTodayResult.isLeft()) return amountDrankTodayResult as Left<Failure, bool>;
    if (dailyDrinkingGoalResult.isLeft()) return dailyDrinkingGoalResult as Left<Failure, bool>;

    int amountDrankToday = amountDrankTodayResult.fold((l) => null, (r) => r) as int;
    int dailyDrinkingGoal = dailyDrinkingGoalResult.fold((l) => null, (r) => r) as int;

    return Right(amountDrankToday + amount > dailyDrinkingGoal);
  }
}
