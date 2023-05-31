import 'package:hive/hive.dart';

class MyHive {
  final HiveInterface _hiveInterface;

  const MyHive(this._hiveInterface);

  void init(String path) {
    _hiveInterface.init(path);
  }

  Future<void> openBoxes(List<String> boxesNamesToOpen) async {
    for (var boxName in boxesNamesToOpen) {
      await _hiveInterface.openBox(boxName);
    }
  }

  // TODO: create tests
  void registerAdapters(List<TypeAdapter> adapters) {
    // TODO: create test
    for (var adapter in adapters) {
      _hiveInterface.registerAdapter(adapter);
    }
  }
}
