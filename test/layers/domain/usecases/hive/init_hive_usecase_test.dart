import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_box.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/int_hive/init_hive_local_datasource_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/init_hive_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/init_hive/init_hive_usecase.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/init_hive/init_hive_usecase_imp.dart';

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
      initHiveRepository: InitHiveRepositoryImp(
        InitHiveLocalDataSourceImp(),
      ),
      openHiveBoxList: [
        OpenHiveTestBoxImp(),
      ],
    );

    await initHiveUseCaseImp();

    expect(true, await Hive.boxExists('testBox'));
  });
}
