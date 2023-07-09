import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../repositories/user_repository.dart';

abstract interface class CalculateDailyDrinkingGoalUseCase {
  Future<Result<double>> call();
}

class CalculateDailyDrinkingGoalUseCaseImp implements CalculateDailyDrinkingGoalUseCase {
  final UserRepository _userRepository;

  CalculateDailyDrinkingGoalUseCaseImp(this._userRepository);

  @override
  Future<Result<double>> call() async {
    var weight = await _userRepository.getWeight().then((result) => result.fold(
          (failure) => failure,
          (success) => success,
        ));

    if (weight is Failure) return Left(weight);
    weight = weight as int;

    var weeklyWorkoutDays = await _userRepository.getWeeklyWorkoutDays().then((result) => result.fold(
          (failure) => failure,
          (success) => success,
        ));

    if (weeklyWorkoutDays is Failure) return Left(weeklyWorkoutDays);
    weeklyWorkoutDays = weeklyWorkoutDays as int;

    return Right(weight * 35 + ((500 * weeklyWorkoutDays) / 7));
  }
}
