import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import '../utils/dialogs.dart';
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

  Future<void> update({required TimeOfDay key, required TimeOfDay newValue}) async {
    var updateTimeToDrinkResult = await getResult(_waterRepository.updateTimeToDrink(key, newValue));

    if (updateTimeToDrinkResult is Failure) throw Exception();

    var getTimesToDrinkResult = await getResult(_waterRepository.getTimesToDrink());
    if (getTimesToDrinkResult is Failure) throw Exception();

    reminders = getTimesToDrinkResult;

    getIt<WaterController>().init();

    notifyListeners();
  }

  Future<void> delete({
    required TimeOfDay timeToDrink,
    required BuildContext context,
  }) async {
    await Dialogs.confirm(
      title: 'Excluir lembrete?',
      text: 'O lembrete não poderá ser recuperado',
      cancelText: 'Cancelar',
      confirmText: 'Sim, excluir',
      onYes: () async {
        int timesToDrinkCount = (await getResult(_waterRepository.getTimesToDrink())).length;

        if (timesToDrinkCount == 1) {
          SnackBarMessage.normal(context: context, text: 'Deve haver ao menos uma notificação');
        }

        var deleteTimeToDrinkResult = await getResult(_waterRepository.deleteTimeToDrink(timeToDrink));
        if (deleteTimeToDrinkResult is Failure) throw Exception();

        var setDailyDrinkingFrequency = await getResult(_waterRepository.setDailyFrequency(timesToDrinkCount));
        if (setDailyDrinkingFrequency is Failure) throw Exception();

        reminders.removeWhere((reminder) => reminder == timeToDrink);

        getIt<WaterController>().init();

        notifyListeners();

        Navigator.pop(context);

        SnackBarMessage.undo(
            context: context,
            text: 'Lembrete excluído',
            onPressed: () {
              // TODO: implement
            });
      },
      onNo: () {
        Navigator.pop(context);
      },
      context: context,
    );
  }
}
