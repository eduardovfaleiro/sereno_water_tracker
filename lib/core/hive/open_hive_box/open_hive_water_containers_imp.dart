import 'package:hive/hive.dart';

import 'open_hive_box.dart';

class OpenHiveWaterContainersBoxImp implements OpenHiveBox {
  @override
  Future<Box> call() async {
    return await Hive.openBox('waterContainersBox');
  }
}
