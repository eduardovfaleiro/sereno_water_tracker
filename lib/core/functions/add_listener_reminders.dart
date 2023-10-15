import 'package:hive_flutter/hive_flutter.dart';

import '../core.dart';

void addListenerReminders(Function() onListened) {
  getIt<HiveInterface>().box(WATER).listenable(keys: [TIMES_TO_DRINK]).addListener(() {
    onListened();
  });
}
