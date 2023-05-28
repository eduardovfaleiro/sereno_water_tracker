import 'package:hive/hive.dart';

class MyHive {
  final HiveInterface _hiveInterface;

  const MyHive(this._hiveInterface);

  void init(String path) {
    _hiveInterface.init(path);
  }

  Future<void> openBoxes(List<String> boxesNamesToOpen) async {
    for (String boxName in boxesNamesToOpen) {
      await _hiveInterface.openBox(boxName);
    }
  }
}
