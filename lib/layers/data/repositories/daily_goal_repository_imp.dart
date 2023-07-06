import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_goal_repository.dart';
import '../datasources/daily_goal_datasource.dart';

class DailyDrinkingGoalRepositoryImp implements DailyDrinkingGoalRepository {
  final DailyDrinkingGoalDataSource _dailyDrinkingGoalDataSource;

  DailyDrinkingGoalRepositoryImp(this._dailyDrinkingGoalDataSource);

  @override
  Future<Either<Failure, void>> create(int amount) async {
    // try {
    return Right(_dailyDrinkingGoalDataSource.create(amount));
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<int>> get() async {
    // try {
    return Right(await _dailyDrinkingGoalDataSource.get());
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<int>> update(int amount) {
    throw UnimplementedError();
  }
}
