import 'package:hive_flutter/hive_flutter.dart';

import '../../water/domain/entities/water_container_entity.dart';
import '../core.dart';
import '../functions/validate_session.dart';

Future<void> initHive() async {
  HiveInterface hive = getIt<HiveInterface>();

  await hive.initFlutter();

  hive.registerAdapter(WaterContainerEntityAdapter());

  await hive.openBox(WATER);
  await hive.openBox(USER);
  await hive.openBox(WATER_CONTAINER);

  if (hive.box(WATER_CONTAINER).isEmpty && !await validateSession()) {
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 100, assetName: 'cup_of_tea.svg'));
    await hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 20000, assetName: 'gallon.svg'));
  }
}
