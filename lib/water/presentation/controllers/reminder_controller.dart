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

  Future<void> add({
    required TimeOfDay reminder,
    required BuildContext context,
  }) async {
    var addTimeToDrinkResult = await getResult(_waterRepository.addTimeToDrink(reminder));

    if (addTimeToDrinkResult is Failure) {
      return SnackBarMessage.error(addTimeToDrinkResult, context: context);
    }

    reminders.add(reminder);

    notifyListeners();
  }

  Future<void> update({
    required TimeOfDay key,
    required TimeOfDay newValue,
  }) async {
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
      text: 'Deseja mesmo excluir lembrete?',
      cancelText: 'Cancelar',
      confirmText: 'Sim, excluir',
      onYes: () async {
        int timesToDrinkCount = (await getResult(_waterRepository.getTimesToDrink())).length;

        if (timesToDrinkCount == 1) {
          SnackBarMessage.normal(context: context, text: 'Deve haver ao menos um lembrete');
          Navigator.pop(context);
          return;
        }

        var deleteTimeToDrinkResult = await getResult(_waterRepository.deleteTimeToDrink(timeToDrink));
        if (deleteTimeToDrinkResult is Failure) throw Exception();

        var setDailyDrinkingFrequency = await getResult(_waterRepository.setDailyFrequency(timesToDrinkCount - 1));
        if (setDailyDrinkingFrequency is Failure) throw Exception();

        reminders.removeWhere((reminder) => reminder == timeToDrink);

        getIt<WaterController>().init();

        notifyListeners();

        Navigator.pop(context);

        SnackBarMessage.undo(
          context: context,
          text: 'Lembrete excluído',
          onPressed: () async {
            var addTimeToDrinkResult = await getResult(_waterRepository.addTimeToDrink(timeToDrink));

            if (addTimeToDrinkResult is Failure) {
              return SnackBarMessage.normal(text: 'Não foi possível desfazer exclusão', context: context);
            }

            reminders.add(timeToDrink);

            notifyListeners();
          },
        );
      },
      onNo: () {
        Navigator.pop(context);
      },
      context: context,
    );
  }
}
