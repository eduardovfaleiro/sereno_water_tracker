import 'package:hive/hive.dart';

import 'open_hive_box.dart';

class OpenWaterContainersHiveBoxImp implements OpenHiveBox {
  @override
  Future<Box> call() async {
    return await Hive.openBox('waterContainers');
  }
}
