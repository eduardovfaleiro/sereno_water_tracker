import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import '../utils/snackbar_message.dart';
import 'water_controller.dart';

class ReminderController extends ChangeNotifier {
  final WaterRepository _waterRepository;

  ReminderController(this._waterRepository);

  List<TimeOfDay> reminders = [];

  Future<void> init() async {
    var getTimesToDrinkResult = await getResult(_waterRepository.getTimesToDrink());
    if (getTimesToDrinkResult is Failure) throw Exception();

    reminders = getTimesToDrinkResult;

    notifyListeners();
  }

  Future<void> add(BuildContext context, TimeOfDay reminder) async {
    var addTimeToDrinkResult = await getResult(_waterRepository.addTimeToDrink(reminder));

    if (addTimeToDrinkResult is Failure) {
      return SnackBarMessage.error(addTimeToDrinkResult, context: context);
    }

    reminders.add(reminder);

    _initWaterController();
    notifyListeners();
  }

  Future<void> update(
    BuildContext context, {
    required TimeOfDay key,
    required TimeOfDay newValue,
  }) async {
    var updateTimeToDrinkResult = await getResult(_waterRepository.updateTimeToDrink(key, newValue));
    var getTimesToDrinkResult = await getResult(_waterRepository.getTimesToDrink());

    if (updateTimeToDrinkResult is Failure) {
      return SnackBarMessage.error(updateTimeToDrinkResult, context: context);
    }

    if (getTimesToDrinkResult is Failure) {
      return SnackBarMessage.error(getTimesToDrinkResult, context: context);
    }

    reminders = getTimesToDrinkResult;

    _initWaterController();
    notifyListeners();
  }

  Future<void> delete(BuildContext context, TimeOfDay timeToDrink) async {
    int timesToDrinkCount = (await getResult(_waterRepository.getTimesToDrink())).length;

    var deleteTimeToDrinkResult = await getResult(_waterRepository.deleteTimeToDrink(timeToDrink));

    if (deleteTimeToDrinkResult is Failure) {
      return SnackBarMessage.error(deleteTimeToDrinkResult, context: context);
    }

    var setDailyDrinkingFrequency = await getResult(_waterRepository.setDailyFrequency(timesToDrinkCount - 1));
    if (setDailyDrinkingFrequency is Failure) throw Exception();

    reminders.removeWhere((reminder) => reminder == timeToDrink);

    _initWaterController();
    notifyListeners();
  }

  void _initWaterController() {
    getIt<WaterController>().init();
  }
}
