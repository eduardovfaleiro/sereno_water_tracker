import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';

class AmountOfWaterDrankTodayRepositoryImp implements AmountOfWaterDrankTodayRepository {
  final AmountOfWaterDrankTodayDataSource _amountOfWaterDrankTodayDataSource;

  AmountOfWaterDrankTodayRepositoryImp(this._amountOfWaterDrankTodayDataSource);

  @override
  Future<Result<int>> get() async {
    try {
      return Right(await _amountOfWaterDrankTodayDataSource.get());
    } catch (e) {
      return Left(CacheFailure("Call to datasource failed."));
    }
  }

  @override
  Future<Result<int>> addUp(int amount) async {
    try {
      return Right(await _amountOfWaterDrankTodayDataSource.addUp(amount));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Result<int>> update(int amount) {
    throw UnimplementedError();
  }
}
