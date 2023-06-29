import 'package:hive_flutter/hive_flutter.dart';

import '../../../layers/data/dtos/water_container/water_container_dto.dart';
import '../../core.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox(WATER_CONTAINER);
  await Hive.openBox(WATER_DATA);
  await Hive.openBox(USER_DATA);

  Hive.registerAdapter(WaterContainerDtoAdapter());
}
