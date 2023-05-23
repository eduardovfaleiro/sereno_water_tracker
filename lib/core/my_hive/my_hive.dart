import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class MyHive {
  final HiveInterface _hiveInterface;

  const MyHive(this._hiveInterface);

  Future<void> initFlutter() async {
    var directory = await getApplicationDocumentsDirectory();

    await _hiveInterface.initFlutter(directory.path);
  }

  Future<void> openBoxes(List<String> boxesNamesToOpen) async {
    for (String boxName in boxesNamesToOpen) {
      await _hiveInterface.openBox(boxName);
    }
  }
}
