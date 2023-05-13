import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'open_hive_box/open_hive_box.dart';

class MyHive {
  static Future<void> init(List<OpenHiveBox> openHiveBoxList) async {
    Directory directory = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(directory.path);

    for (OpenHiveBox openHiveBox in openHiveBoxList) {
      openHiveBox();
    }
  }
}
