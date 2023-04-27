import 'package:sereno_clean_architecture_solid/core/hive/init_flutter_hive/init_flutter_hive.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_box.dart';

class InitHive {
  final InitFlutterHive _initFlutterHiveImp;
  final List<OpenHiveBox> _openHiveBoxImpList;

  InitHive({
    required InitFlutterHive initFlutterHive,
    required List<OpenHiveBox> openHiveBoxList,
  })  : _openHiveBoxImpList = openHiveBoxList,
        _initFlutterHiveImp = initFlutterHive;

  Future<void> call() async {
    await _initFlutterHiveImp();

    for (OpenHiveBox openHiveBoxImp in _openHiveBoxImpList) {
      await openHiveBoxImp();
    }
  }
}
