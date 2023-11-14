import 'package:dart_date/dart_date.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../water/domain/entities/drink_record_entity.dart';
import '../../water/domain/entities/water_container_entity.dart';
import '../../water/domain/services/notification_service.dart';
import '../../water/domain/services/water_container_generator_service.dart';
import '../core.dart';

class HiveInitializer {
  final HiveInterface _hiveInterface;
  final WaterContainerGeneratorService _waterContainerGeneratorService;
  final NotificationService _notificationService;

  HiveInitializer(
    this._hiveInterface,
    this._waterContainerGeneratorService,
    this._notificationService,
  );

  Future<void> initialize() async {
    await _hiveInterface.initFlutter();
  }

  Future<void> registerAdapters() async {
    _hiveInterface.registerAdapter(WaterContainerEntityAdapter());
    _hiveInterface.registerAdapter(DrinkRecordEntityAdapter());
  }

  Future<void> openBoxes() async {
    await _hiveInterface.openBox(WATER);
    await _hiveInterface.openBox(USER);
    await _hiveInterface.openBox(WATER_CONTAINER);
    await _hiveInterface.openBox(DRINK_HISTORY);
  }

  Future<void> startDrinkHistoryReset() async {
    List<DrinkRecordEntity> drinkHistory = List.from(_hiveInterface.box(DRINK_HISTORY).values);

    for (int i = 0; i < drinkHistory.length; i++) {
      if (drinkHistory[i].dateTime.differenceInDays(DateTime.now()) >= 1) {
        _hiveInterface.box(DRINK_HISTORY).deleteAt(i);
      }
    }
  }

  Future<void> generateContainersIfEmpty() async {
    if (_hiveInterface.box(WATER_CONTAINER).isNotEmpty) return;

    List<WaterContainerEntity> waterContainers = await _waterContainerGeneratorService.generate();

    for (WaterContainerEntity waterContainer in waterContainers) {
      await _hiveInterface.box(WATER_CONTAINER).add(waterContainer);
    }
  }

  Future<void> setListenersReminders() async {
    var waterBox = _hiveInterface.box(WATER);

    waterBox.watch(key: TIMES_TO_DRINK).listen((event) async {
      await _notificationService.cancelAllNotifications();
      await _notificationService.scheduleNotifications();
    });
  }
}
