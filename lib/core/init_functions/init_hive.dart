import 'package:hive_flutter/hive_flutter.dart';

import '../core.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox(WATER_CONTAINER);
  await Hive.openBox(WATER);
  await Hive.openBox(USER);
}
