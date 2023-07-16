import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../datasources/amount_of_water_drank_today_datasource.dart';

class AmountOfWaterDrankTodayRepositoryImp implements AmountOfWaterDrankTodayRepository {
  final AmountOfWaterDrankTodayDataSource _amountOfWaterDrankTodayDataSource;

  AmountOfWaterDrankTodayRepositoryImp(this._amountOfWaterDrankTodayDataSource);

  @override
  Future<Result<int>> get() async {
    return Right(await _amountOfWaterDrankTodayDataSource.get());
  }

  @override
  Future<Result<void>> addUp(int amount) async {
    return Right(await _amountOfWaterDrankTodayDataSource.addUp(amount));
  }

  // TODO: test method
  @override
  Future<Result<void>> update(int amount) async {
    return Right(await _amountOfWaterDrankTodayDataSource.update(amount));
  }
}
