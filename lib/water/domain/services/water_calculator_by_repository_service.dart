import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import 'water_calculator_service.dart';

abstract class WaterCalculatorByRepositoryService {
  Future<Result<int>> calculateWaterPerDrinkByCustomReminders();
}

class WaterCalculatorByRepositoryServiceImp implements WaterCalculatorByRepositoryService {
  final WaterRepository _waterRepository;
  final WaterCalculatorService _waterCalculatorService;

  WaterCalculatorByRepositoryServiceImp(this._waterRepository, this._waterCalculatorService);

  @override
  Future<Result<int>> calculateWaterPerDrinkByCustomReminders() async {
    var getDailyDrinkingGoalResult = await getResult(_waterRepository.getDailyDrinkingGoal());
    var getDailyDrikingFrequencyResult = await getResult(_waterRepository.getDailyDrinkingFrequency());

    if (getDailyDrinkingGoalResult is Failure) {
      return Left(getDailyDrinkingGoalResult);
    }

    if (getDailyDrikingFrequencyResult is Failure) {
      return Left(getDailyDrikingFrequencyResult);
    }

    int dailyDrinkingGoal = getDailyDrinkingGoalResult;
    int dailyDrikingFrequency = getDailyDrikingFrequencyResult;

    int waterPerDrink = _waterCalculatorService.calculateWaterPerDrinkByCustomReminders(
      dailyDrinkingGoal,
      dailyDrikingFrequency,
    );

    return Right(waterPerDrink);
  }
}
