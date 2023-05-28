import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';

class AmountOfWaterDrankTodayRepositoryImp implements AmountOfWaterDrankTodayRepository {
  final AmountOfWaterDrankTodayDataSource _amountOfWaterDrankTodayDataSource;

  AmountOfWaterDrankTodayRepositoryImp(this._amountOfWaterDrankTodayDataSource);

  @override
  Future<Either<Failure, int>> get() async {
    try {
      return Right(await _amountOfWaterDrankTodayDataSource.get());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addUp(int amount) async {
    try {
      return Right(await _amountOfWaterDrankTodayDataSource.addUp(amount));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> update(int amount) {
    throw UnimplementedError();
  }
}
