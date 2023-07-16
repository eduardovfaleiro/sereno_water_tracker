import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_goal_repository.dart';
import '../datasources/daily_goal_datasource.dart';

class DailyDrinkingGoalRepositoryImp implements DailyDrinkingGoalRepository {
  final DailyDrinkingGoalDataSource _dailyDrinkingGoalDataSource;

  DailyDrinkingGoalRepositoryImp(this._dailyDrinkingGoalDataSource);

  @override
  Future<Result<int>> get() async {
    return Right(await _dailyDrinkingGoalDataSource.get());
  }

  @override
  Future<Result<void>> update(int amount) async {
    return Right(await _dailyDrinkingGoalDataSource.update(amount));
  }
}
