import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_data_entity.dart';
import '../datasources/water_datasource.dart';

abstract class WaterRepository {
  Future<Result<int>> getDrankToday();
  Future<Result<int>> getDailyDrinkingGoal();
  Future<Result<int>> getDailyDrinkingFrequency();
  Future<Result<double>> getDrankTodayPercentage();
  Future<Result<WaterDataEntity>> getWaterData();
  Future<Result<List<TimeOfDay>>> getTimesToDrink();
  Future<Result<DateTime?>> getLastDrankTodayReset();

  Future<Result<void>> setDrankToday(int value);
  Future<Result<void>> addDrankToday(int value);
  Future<Result<void>> removeDrankToday(int value);
  Future<Result<void>> setDailyDrinkingGoal(int value);
  Future<Result<void>> setDailyFrequency(int value);
  Future<Result<void>> setWaterData(WaterDataEntity value);
  Future<Result<void>> setLastDrankTodayReset(DateTime value);

  Future<Result<void>> deleteTimeToDrink(TimeOfDay value);
}

class WaterRepositoryImp implements WaterRepository {
  final WaterDataSource _waterDataSource;

  WaterRepositoryImp(this._waterDataSource);

  @override
  Future<Result<int>> getDailyDrinkingFrequency() async {
    return Right(await _waterDataSource.getDailyDrinkingFrequency());
  }

  @override
  Future<Result<int>> getDailyDrinkingGoal() async {
    return Right(await _waterDataSource.getDailyDrinkingGoal());
  }

  @override
  Future<Result<int>> getDrankToday() async {
    return Right(await _waterDataSource.getDrankToday());
  }

  @override
  Future<Result<double>> getDrankTodayPercentage() async {
    int drankToday = await _waterDataSource.getDrankToday();
    int dailyDrinkingGoal = await _waterDataSource.getDailyDrinkingGoal();

    return Right(drankToday / dailyDrinkingGoal);
  }

  @override
  Future<Result<DateTime?>> getLastDrankTodayReset() async {
    return Right(await _waterDataSource.getLastDrankTodayReset());
  }

  @override
  Future<Result<void>> setLastDrankTodayReset(DateTime value) async {
    return Right(await _waterDataSource.setLastDrankTodayReset(value));
  }

  @override
  Future<Result<List<TimeOfDay>>> getTimesToDrink() async {
    return Right(await _waterDataSource.getTimesToDrink());
  }

  @override
  Future<Result<void>> setDailyFrequency(int value) async {
    return Right(await _waterDataSource.setDailyDrinkingFrequency(value));
  }

  @override
  Future<Result<void>> setDailyDrinkingGoal(int value) async {
    return Right(await _waterDataSource.setDailyDrinkingGoal(value));
  }

  @override
  Future<Result<void>> setDrankToday(int value) async {
    if (value.isNegative) {
      return Left(NegativeNumberFailure());
    }

    return Right(await _waterDataSource.setDrankToday(value));
  }

  @override
  Future<Result<void>> addDrankToday(int value) async {
    int drankToday = await _waterDataSource.getDrankToday();
    return Right(await _waterDataSource.setDrankToday(drankToday + value));
  }

  @override
  Future<Result<void>> removeDrankToday(int value) async {
    int drankToday = await _waterDataSource.getDrankToday();
    int newDrankToday = drankToday - value;

    if (newDrankToday.isNegative) {
      return Left(NegativeNumberFailure());
    }

    return Right(await _waterDataSource.setDrankToday(drankToday - value));
  }

  @override
  Future<Result<void>> setWaterData(WaterDataEntity value) async {
    await _waterDataSource.setDailyDrinkingFrequency(value.dailyDrinkingFrequency);
    await _waterDataSource.setDailyDrinkingGoal(value.dailyGoal);
    await _waterDataSource.setDrankToday(value.drankToday);
    await _waterDataSource.setTimesToDrink(value.timesToDrink);

    return const Right(null);
  }

  @override
  Future<Result<WaterDataEntity>> getWaterData() async {
    int dailyDrinkingFrequency = await _waterDataSource.getDailyDrinkingFrequency();
    int dailyDrinkingGoal = await _waterDataSource.getDailyDrinkingGoal();
    int drankToday = await _waterDataSource.getDrankToday();
    List<TimeOfDay> timesToDrink = await _waterDataSource.getTimesToDrink();

    return Right(
      WaterDataEntity(
        drankToday: drankToday,
        dailyGoal: dailyDrinkingGoal,
        dailyDrinkingFrequency: dailyDrinkingFrequency,
        timesToDrink: timesToDrink,
      ),
    );
  }

  @override
  Future<Result<void>> deleteTimeToDrink(TimeOfDay value) async {
    return Right(await _waterDataSource.deleteTimeToDrink(value));
  }
}
