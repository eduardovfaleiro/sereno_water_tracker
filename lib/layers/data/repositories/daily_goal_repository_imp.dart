import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_goal_repository.dart';
import '../datasources/daily_goal/daily_goal_datasource.dart';

class DailyGoalRepositoryImp implements DailyGoalRepository {
  final DailyGoalDataSource _dailyGoalDataSource;

  DailyGoalRepositoryImp(this._dailyGoalDataSource);

  @override
  Future<Either<Failure, void>> create(int amount) async {
    try {
      return Right(_dailyGoalDataSource.create(amount));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<int>> get() async {
    try {
      return Right(await _dailyGoalDataSource.get());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<int>> update(int amount) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
