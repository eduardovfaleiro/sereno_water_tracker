import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/daily_drinking_frequency_repository.dart';
import '../datasources/daily_drinking_frequency_datasource.dart';

class DailyDrinkingFrequencyRepositoryImp implements DailyDrinkingFrequencyRepository {
  final DailyDrinkingFrequencyDataSource _dailyDrinkingFrequencyDataSouce;

  DailyDrinkingFrequencyRepositoryImp(this._dailyDrinkingFrequencyDataSouce);

  @override
  Future<Result<int>> get() async {
    try {
      return Right(await _dailyDrinkingFrequencyDataSouce.get());
    } catch (error) {
      return Left(CacheFailure());
    }
  }
}
