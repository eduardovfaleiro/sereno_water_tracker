import 'package:flutter/material.dart';
import 'package:sereno_clean_architecture_solid/core/hive/open_hive_box/open_hive_water_box_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/ui/pages/display/water/water_display_page.dart';

import 'core/hive/init_flutter_hive/init_flutter_hive_imp.dart';
import 'core/hive/init_hive.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitHive(
    initFlutterHive: InitFlutterHiveImp(),
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
