import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_box.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_flutter_hive/init_flutter_hive_usecase_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_hive/init_hive_usecase.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_hive/init_hive_usecase_imp.dart';

class OpenHiveTestBoxImp implements OpenHiveBox {
  @override
  Future<Box> call() async {
    return await Hive.openBox('testBox');
  }
}

main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Should return true', () async {
    InitHiveUseCase initHiveUseCaseImp = InitHiveUseCaseImp(
      initFlutterHive: InitFlutterHiveUseCaseImp(),
      openHiveBoxList: [
        OpenHiveTestBoxImp(),
      ],
    );

    initHiveUseCaseImp();

    expect(true, await Hive.boxExists('testBox'));
  });

  // class InitHiveUseCaseImp implements InitHiveUseCase {
  //   final InitFlutterHiveUseCase _initFlutterHiveImp;
  //   final List<OpenHiveBox> _openHiveBoxImpList;

  //   InitHiveUseCaseImp({
  //     required InitFlutterHiveUseCase initFlutterHive,
  //     required List<OpenHiveBox> openHiveBoxList,
  //   })  : _openHiveBoxImpList = openHiveBoxList,
  //         _initFlutterHiveImp = initFlutterHive;

  //   @override
  //   Future<void> call() async {
  //     await _initFlutterHiveImp();

  //     for (OpenHiveBox openHiveBoxImp in _openHiveBoxImpList) {
  //       await openHiveBoxImp();
  //     }
  //   }
  // }
}
