import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/init_hive_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/open_hive_boxes_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_hive/init_hive_usecase_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/open_hive_boxes/open_hive_boxes_usecase_imp.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InitHiveUseCaseImp(InitHiveRepositoryImp())();

  await OpenHiveBoxesUseCaseImp(
    OpenHiveBoxesRepositoryImp(
      ['water', 'waterContainers'],
    ),
  )();

  test('Should return true', () async {
    bool result = await Hive.boxExists('waterContainers');

    expect(true, result);
  });
}
