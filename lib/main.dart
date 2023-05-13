import 'package:flutter/material.dart';

import 'core/inject/inject.dart';
import 'core/my_hive/my_hive.dart';
import 'core/my_hive/open_hive_box/open_user_data_hive_box_imp.dart';
import 'core/my_hive/open_hive_box/open_water_containers_hive_box_imp.dart';
import 'core/theme/themes.dart';
import 'layers/presentation/ui/pages/display/water/water_display_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.init();
  await MyHive.init([
    OpenWaterContainersHiveBoxImp(),
    OpenUserDataHiveBoxImp(),
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterDisplayPage(),
      theme: Themes.dark,
    ),
  );
}
