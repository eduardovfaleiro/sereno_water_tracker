import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../usecases/calculate_water_data_usecase.dart';

abstract class CheckDataForChangesService {
  Future<Result<bool>> weeklyWorkoutDays(int weeklyWorkoutDays);
  Future<Result<bool>> weight(int weight);
  Future<Result<bool>> isDailyGoalCustom(int dailyGoalToCompare);
}

class CheckDataForChangesServiceImp implements CheckDataForChangesService {
  final UserRepository _userRepository;
  final CalculateWaterDataUseCase _calculateWaterDataUseCase;

  CheckDataForChangesServiceImp(this._userRepository, this._calculateWaterDataUseCase);

  @override
  Future<Result<bool>> weeklyWorkoutDays(weeklyWorkoutDays) async {
    // Get results
    var getWeeklyWorkoutDaysResult = await getResult(_userRepository.getWeeklyWorkoutDays());

    // Failure handling
    if (getWeeklyWorkoutDaysResult is Failure) {
      return Left(getWeeklyWorkoutDaysResult);
    }

    // Assign
    final repositoryWeeklyWorkoutDays = getWeeklyWorkoutDaysResult as int;

    // Act
    return Right(weeklyWorkoutDays != repositoryWeeklyWorkoutDays);
  }

  @override
  Future<Result<bool>> weight(weight) async {
    // Get results
    var getWeight = await getResult(_userRepository.getWeight());

    // Failure handling
    if (getWeight is Failure) {
      return Left(getWeight);
    }

    // Assign
    final repositoryWeight = getWeight as int;

    // Act
    return Right(repositoryWeight != weight);
  }

  // TODO: arruma essa macaquisse
  @override
  Future<Result<bool>> isDailyGoalCustom(dailyGoalToCompare) async {
    // Get results
    var calculateWaterDataResult = await getResult(_calculateWaterDataUseCase());

    // Failure handling
    if (calculateWaterDataResult is Failure) {
      return Left(calculateWaterDataResult);
    }

    // Assign
    final repositoryDailyGoal = calculateWaterDataResult.dailyGoal as int;

    // Act
    return Right(repositoryDailyGoal != dailyGoalToCompare);
  }
}
