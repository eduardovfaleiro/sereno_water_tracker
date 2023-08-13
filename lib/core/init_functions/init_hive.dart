import 'package:hive_flutter/hive_flutter.dart';

import '../../water/domain/entities/water_container_entity.dart';
import '../core.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WaterContainerEntityAdapter());

  await Hive.openBox(WATER_CONTAINER);

  if (Hive.box(WATER_CONTAINER).isEmpty) {
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 200, assetName: 'cup.svg'));
    await Hive.box(WATER_CONTAINER).add(const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'));
  }

  await Hive.openBox(WATER);
  await Hive.openBox(USER);
}
