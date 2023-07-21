import 'package:hive_flutter/hive_flutter.dart';

import '../../../water/data/dtos/water_container/water_container_dto.dart';
import '../../core.dart';
import '../enums/water_container_icon.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WaterContainerIconAdapter());
  Hive.registerAdapter(WaterContainerDtoAdapter());

  await Hive.openBox(WATER_CONTAINER);
  await Hive.openBox(WATER_DATA);
  await Hive.openBox(USER_DATA);
}
