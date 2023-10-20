import 'package:dart_date/dart_date.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../water/domain/entities/drink_record_entity.dart';
import '../../water/domain/entities/water_container_entity.dart';
import '../../water/domain/services/notification_service.dart';
import '../core.dart';
import '../functions/validate_session.dart';

Future<void> initHive() async {
  HiveInterface hive = getIt<HiveInterface>();

  await hive.initFlutter();

  hive.registerAdapter(WaterContainerEntityAdapter());
  hive.registerAdapter(DrinkRecordEntityAdapter());
  await hive.openBox(WATER);
  await hive.openBox(USER);
  await hive.openBox(WATER_CONTAINER);
  await hive.openBox(DRINK_HISTORY);

  List<DrinkRecordEntity> drinkHistory = List.from(hive.box(DRINK_HISTORY).values);

  for (int i = 0; i < drinkHistory.length; i++) {
    if (drinkHistory[i].dateTime.differenceInDays(DateTime.now()) >= 1) {
      hive.box(DRINK_HISTORY).deleteAt(i);
    }
  }

  await _initializeReminders(hive);

  if (hive.box(WATER_CONTAINER).isEmpty && !await validateSession()) {
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 100, assetName: 'cup_of_tea.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 20000, assetName: 'gallon.svg'));
  }
}

Future<void> _initializeReminders(HiveInterface hiveInterface) async {
  var notificationService = getIt<NotificationService>();
  var waterBox = hiveInterface.box(WATER);

  waterBox.watch(key: TIMES_TO_DRINK).listen((event) async {
    await notificationService.scheduleNotifications();
  });
}
