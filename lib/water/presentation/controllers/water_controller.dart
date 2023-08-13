import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_container_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/services/time_to_drink_service.dart';
import '../utils/snackbar_message.dart';

class WaterController extends ChangeNotifier {
  bool isLoading = false;

  final TimeToDrinkAgainServiceImp _timeToDrinkAgainServiceImp;
  final WaterContainerRepository _waterContainerRepository;
  final WaterRepository _waterRepository;

  WaterController(this._waterRepository, this._timeToDrinkAgainServiceImp, this._waterContainerRepository);

  late WaterDataEntity waterData;
  List<WaterContainerEntity> waterContainers = [];

  Future<void> init() async {
    isLoading = true;

    final waterDataResult = await getResult(_waterRepository.getWaterData());

    if (waterDataResult is Failure) throw Exception();

    waterData = waterDataResult.copyWith();

    final waterContainers = await getResult(_waterContainerRepository.getAll());
    if (waterContainers is Failure) throw Exception();

    this.waterContainers = waterContainers;

    isLoading = false;

    notifyListeners();
  }

  Stream<Duration> startTimerToDrink() async* {
    DateTime nextTimeToDrink = await getResult(_timeToDrinkAgainServiceImp.getNext());
    Duration drinkAgainIn = nextTimeToDrink.difference(DateTime.now());

    while (drinkAgainIn.inSeconds >= 0) {
      for (int second = drinkAgainIn.inSeconds; second >= 0; second--) {
        await Future.delayed(const Duration(seconds: 1));
        drinkAgainIn = nextTimeToDrink.difference(DateTime.now());
        yield drinkAgainIn;
      }
    }
  }

  Future<void> addDrankToday({required int amount, required BuildContext context}) async {
    final drankTodayResult = await _waterRepository.addDrankToday(amount);

    if (drankTodayResult is Failure) {
      SnackBarMessage.error(drankTodayResult as Failure, context: context);
      return;
    }

    waterData.drankToday += amount;

    notifyListeners();
  }

  Future<Result<List<WaterContainerEntity>>> getAll() async {
    final getAllWaterContainersResult = await getResult(_waterContainerRepository.getAll());

    if (getAllWaterContainersResult is Failure) return Left(getAllWaterContainersResult);

    return Right(getAllWaterContainersResult);
  }
}
