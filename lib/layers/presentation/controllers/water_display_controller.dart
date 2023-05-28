import 'package:flutter/material.dart';

import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../domain/repositories/water_container_repository.dart';

class WaterDisplayController extends ChangeNotifier {
  final AmountOfWaterDrankTodayRepository _amountOfWaterDrankTodayRepository;
  final WaterContainerRepository _waterContainerRepository;

  WaterDisplayController(this._waterContainerRepository, this._amountOfWaterDrankTodayRepository);

  // TODO: pega o repo do resocoder e vê como ele faz
  Future<int> getAmountOfWaterDrankToday() async {
    return _amountOfWaterDrankTodayRepository.get();
  }

  Future<int> createWaterContainer(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.create(waterContainerEntity);
  }

  Future<void> deleteWaterContainer(int id) {
    return _waterContainerRepository.delete(id);
  }
}
