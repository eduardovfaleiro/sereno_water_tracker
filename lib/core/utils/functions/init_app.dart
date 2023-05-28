import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../database/my_hive.dart';
import '../injection/inject.dart';

Future<void> initApp() async {
  // Inject
  Inject.init();

  // Hive
  var myHive = MyHive(Hive);

  myHive.init(await getApplicationDocumentsDirectory().then((directory) => directory.path));
  await myHive.openBoxes(['waterContainers', 'waterData']);
}
