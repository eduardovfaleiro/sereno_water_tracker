import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_water_box_imp.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_water_containers_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/save_water_container/save_water_container_local_datasource_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/save_water_container_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_flutter_hive/init_flutter_hive_usecase_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/init_hive/init_hive_usecase_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/save_water_container/save_water_container_usecase_imp.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  InitHiveUseCaseImp(
    initFlutterHive: InitFlutterHiveUseCaseImp(),
    openHiveBoxList: [
      OpenHiveWaterBoxImp(),
      OpenHiveWaterContainersBoxImp(),
    ],
  )();

  test(
    'Should return int',
    () async {
      var useCase = SaveWaterContainerUseCaseImp(
        SaveWaterContainerRepositoryImp(
          SaveWaterContainerLocalDataSourceImp(),
        ),
      );

      var result = await useCase(WaterContainerEntity(200, 'Cup'));

      expect(result, isInstanceOf<int>());
    },
  );
}
