import 'dart:async';

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
  bool isLoading = false;
  bool isTimerStarted = false;

  Future<void> init() async {
    isLoading = true;

    final waterDataResult = await getResult(_waterRepository.getWaterData());

    if (waterDataResult is Failure) throw Exception();

    waterData = waterDataResult.copyWith();

    timerToDrinkService.start();

    isLoading = false;

    notifyListeners();
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

  Future<void> removeDrankToday({required int amount, required BuildContext context}) async {
    final drankTodayResult = await _waterRepository.removeDrankToday(amount);

    if (drankTodayResult is Failure) {
      SnackBarMessage.error(drankTodayResult as Failure, context: context);
      return;
    }

    waterData.drankToday -= amount;

    notifyListeners();
  }
}
