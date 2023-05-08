import 'package:flutter/material.dart';

import 'layers/data/repositories/init_hive_repository_imp.dart';
import 'layers/domain/usecases/hive/init_hive/init_hive_usecase_imp.dart';
import 'layers/presentation/ui/pages/display/water/water_display_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InitHiveUseCaseImp(InitHiveRepositoryImp())();

  runApp(
    const MaterialApp(
      home: WaterDisplayPage(),
    ),
  );
}
