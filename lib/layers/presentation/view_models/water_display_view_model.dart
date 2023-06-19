import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../domain/repositories/daily_goal_repository.dart';
import '../../domain/repositories/water_container_repository.dart';

class WaterDisplayViewModel extends ChangeNotifier {
  final DailyGoalRepository _dailyGoalRepository;
  final WaterContainerRepository _waterContainerRepository;
  final AmountOfWaterDrankTodayRepository _amountOfWaterDrankTodayRepository;

  WaterDisplayViewModel(
    this._dailyGoalRepository,
    this._waterContainerRepository,
    this._amountOfWaterDrankTodayRepository,
  );

  Future<Result<int>> getDailyGoal() {
    return _dailyGoalRepository.get();
  }

  Future<Result<int>> getAmountOfWaterDrankToday(BuildContext context) async {
    return _amountOfWaterDrankTodayRepository.get();
  }

  Future<void> createWaterContainer(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.create(waterContainerEntity);
  }

  Future<void> deleteWaterContainer(int id) {
    return _waterContainerRepository.delete(id);
  }
}
