import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../database/my_hive.dart';
import '../constants/constants.dart';
import '../injection/inject.dart';

Future<void> initApp() async {
  // Inject
  Inject.init();

  // Hive
  var myHive = MyHive(GetIt.I.get<HiveInterface>());

  myHive.init(await getApplicationDocumentsDirectory().then((directory) => directory.path));
  await myHive.openBoxes([WATER_CONTAINER, WATER_DATA]);
}
