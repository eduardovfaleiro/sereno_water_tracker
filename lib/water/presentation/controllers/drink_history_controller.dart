import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/core.dart';
import '../../data/repositories/drink_history_repository.dart';
import '../../domain/entities/drink_record_entity.dart';

class DrinkHistoryController {
  final ValueNotifier<List<DrinkRecordEntity>> records = ValueNotifier([]);
  final DrinkHistoryRepository _drinkHistoryRepository;

  DrinkHistoryController(this._drinkHistoryRepository);

  void initialize() {
    getIt<HiveInterface>().box(DRINK_HISTORY).listenable().addListener(() {
      records.value = List.from(getIt<HiveInterface>().box(DRINK_HISTORY).values);
    });
  }

  Future<void> remove(DrinkRecordEntity drinkRecordEntity) {
    return _drinkHistoryRepository.remove(drinkRecordEntity);
  }

  Future<void> removeAll() {
    return _drinkHistoryRepository.removeAll();
  }
}
