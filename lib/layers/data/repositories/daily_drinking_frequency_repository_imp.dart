import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_drinking_frequency_repository.dart';
import '../datasources/times_to_drink_per_day_datasource.dart';

class TimesToDrinkPerDayRepositoryImp implements TimesToDrinkPerDayRepository {
  final TimesToDrinkPerDayDataSource _timesToDrinkPerDayDataSouce;

  TimesToDrinkPerDayRepositoryImp(this._timesToDrinkPerDayDataSouce);

  @override
  Future<Result<int>> get() async {
    try {
      return Right(await _timesToDrinkPerDayDataSouce.get());
    } catch (error) {
      return Left(CacheFailure(error.toString()));
    }
  }
}
