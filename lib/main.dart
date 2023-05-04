import 'package:flutter/material.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/int_hive/init_hive_local_datasource_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/init_hive_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/ui/pages/display/water/water_display_page.dart';

import 'layers/domain/usecases/hive/init_hive/init_hive_usecase_imp.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitHiveUseCaseImp(
    initHiveRepository: InitHiveRepositoryImp(
      InitHiveLocalDataSourceImp(),
    ),
    openHiveBoxList: [
      OpenHiveWaterBoxImp(),
    ],
  );

  runApp(
    const MaterialApp(
      home: WaterDisplayPage(),
    ),
  );
}
