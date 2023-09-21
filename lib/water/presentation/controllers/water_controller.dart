import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/services/timer_to_drink_service.dart';
import '../utils/snackbar_message.dart';

class WaterController extends ChangeNotifier {
  final WaterRepository _waterRepository;
  final TimerToDrinkService timerToDrinkService;

  WaterController(this._waterRepository, this.timerToDrinkService);

  late WaterDataEntity waterData;
  double? pastDrankTodayPercentage;

  bool isLoading = false;
  bool isTimerStarted = false;

  Future<void> init() async {
    isLoading = true;

    final waterDataResult = await getResult(_waterRepository.getWaterData());

    if (waterDataResult is Failure) throw Exception();

    waterData = waterDataResult.copyWith();
    pastDrankTodayPercentage = waterData.drankTodayPercentage;
    timerToDrinkService.start();

    isLoading = false;

    notifyListeners();
  }

  Future<void> addDrankToday({required int amount, required BuildContext context}) async {
    final drankTodayResult = await getResult(_waterRepository.addDrankToday(amount));

    if (drankTodayResult is Failure) {
      SnackBarMessage.error(drankTodayResult, context: context);
      return;
    }

    pastDrankTodayPercentage = waterData.drankTodayPercentage;
    waterData.drankToday += amount;

    notifyListeners();
  }

  Future<Result<void>> removeDrankToday({required int amount, required BuildContext context}) async {
    final drankTodayResult = await getResult(_waterRepository.removeDrankToday(amount));

    if (drankTodayResult is NegativeNumberFailure) {
      SnackBarMessage.normal(context: context, text: 'Água bebida não pode ser negativa');
      return Left(drankTodayResult);
    }

    if (drankTodayResult is Failure) {
      SnackBarMessage.error(drankTodayResult, context: context);
      return Left(drankTodayResult);
    }

    pastDrankTodayPercentage = waterData.drankTodayPercentage;
    waterData.drankToday -= amount;

    notifyListeners();

    return const Right(null);
  }
}
