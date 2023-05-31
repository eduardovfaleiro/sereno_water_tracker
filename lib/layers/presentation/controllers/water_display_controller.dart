import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/amount_of_water_drank_today_repository.dart';
import '../../domain/repositories/water_container_repository.dart';

class WaterDisplayController extends ChangeNotifier {
  Future<int> get amountOfWaterDrankToday async => _amountOfWaterDrankTodayRepository.get().then((value) => value.foldRight(value));

  final AmountOfWaterDrankTodayRepository _amountOfWaterDrankTodayRepository;
  final WaterContainerRepository _waterContainerRepository;

  WaterDisplayController(this._waterContainerRepository, this._amountOfWaterDrankTodayRepository);

  Future<int?> getAmountOfWaterDrankToday(BuildContext context) async {
    // var result = await _amountOfWaterDrankTodayRepository.get();
    var result = Left(CacheFailure());

    return result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l.message ?? 'Sorry, an error ocurred.'),
        action: SnackBarAction(
            label: 'Try again',
            onPressed: () async {
              await getAmountOfWaterDrankToday(context);
            }),
      ));
      return null;
    }, (r) => r);
  }

  Future<int> createWaterContainer(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.create(waterContainerEntity);
  }

  Future<void> deleteWaterContainer(int id) {
    return _waterContainerRepository.delete(id);
  }
}
