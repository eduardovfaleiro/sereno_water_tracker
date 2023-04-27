import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_box.dart';

import '../init_flutter_hive/init_flutter_hive_usecase.dart';
import 'init_hive_usecase.dart';

class InitHiveUseCaseImp implements InitHiveUseCase {
  final InitFlutterHiveUseCase _initFlutterHiveImp;
  final List<OpenHiveBox> _openHiveBoxImpList;

  InitHiveUseCaseImp({
    required InitFlutterHiveUseCase initFlutterHive,
    required List<OpenHiveBox> openHiveBoxList,
  })  : _openHiveBoxImpList = openHiveBoxList,
        _initFlutterHiveImp = initFlutterHive;

  @override
  Future<void> call() async {
    await _initFlutterHiveImp();

    for (OpenHiveBox openHiveBoxImp in _openHiveBoxImpList) {
      await openHiveBoxImp();
    }
  }
}
