import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/core.dart';
import '../../data/repositories/drink_history_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/drink_record_entity.dart';
import '../utils/snackbar_message.dart';

class DrinkHistoryController {
  final ValueNotifier<List<DrinkRecordEntity>> records = ValueNotifier([]);
  final DrinkHistoryRepository _drinkHistoryRepository;
  final WaterRepository _waterRepository;

  DrinkHistoryController(this._drinkHistoryRepository, this._waterRepository);

  void initialize() {
    Box drinkHistoryBox = getIt<HiveInterface>().box(DRINK_HISTORY);

    records.value = List.from(drinkHistoryBox.values);

    drinkHistoryBox.listenable().addListener(() {
      records.value = List.from(drinkHistoryBox.values);
    });
  }

  Future<void> remove(BuildContext context, DrinkRecordEntity drinkRecordEntity) async {
    var removeDrankTodayResult = await getResult(
      _waterRepository.removeDrankToday(drinkRecordEntity.amount),
    );

    if (removeDrankTodayResult is NegativeNumberFailure) {
      return SnackBarMessage.normal(context: context, text: 'Água bebida não pode ser negativa');
    }

    await _drinkHistoryRepository.remove(drinkRecordEntity);
  }

  Future<void> removeAll() {
    return _drinkHistoryRepository.removeAll();
  }
}
