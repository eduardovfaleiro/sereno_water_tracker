import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../datasources/water_drank_today_datasource.dart';

abstract interface class WaterDrankTodayRepository {
  Future<Result<int>> get();
  Future<Result<void>> set(int value);
  Future<Result<void>> addUp(int value);
  Future<Result<void>> remove(int value);
}

class WaterDrankTodayRepositoryImp implements WaterDrankTodayRepository {
  final WaterDrankTodayDataSource _waterDrankTodayDataSource;

  WaterDrankTodayRepositoryImp(this._waterDrankTodayDataSource);

  @override
  Future<Result<int>> get() async {
    return Right(await _waterDrankTodayDataSource.get());
  }

  @override
  Future<Result<void>> addUp(int amount) async {
    return Right(await _waterDrankTodayDataSource.add(amount));
  }

  // TODO: test method
  @override
  Future<Result<void>> set(int amount) async {
    return Right(await _waterDrankTodayDataSource.set(amount));
  }

  @override
  Future<Result<void>> remove(int amount) async {
    return Right(await _waterDrankTodayDataSource.remove(amount));
  }
}
