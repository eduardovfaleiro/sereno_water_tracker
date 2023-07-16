import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_drinking_frequency_repository.dart';
import '../datasources/daily_drinking_frequency_datasource.dart';

class NumberOfTimesToDrinkWaterDailyRepositoryImp implements NumberOfTimesToDrinkWaterDailyRepository {
  final NumberOfTimesToDrinkWaterDailyDataSource _numberOfTimesToDrinkWaterDailyDataSouce;

  NumberOfTimesToDrinkWaterDailyRepositoryImp(this._numberOfTimesToDrinkWaterDailyDataSouce);

  @override
  Future<Result<int>> get() async {
    // try {
    return Right(await _numberOfTimesToDrinkWaterDailyDataSouce.get());
    // } catch (error) {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Result<void>> update(int times) async {
    return Right(await _numberOfTimesToDrinkWaterDailyDataSouce.update(times));
  }
}
