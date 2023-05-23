import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'core/my_hive/my_hive.dart';
import 'core/theme/themes.dart';
import 'layers/presentation/ui/pages/display/water/water_display_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject.init();

  var myHive = MyHive(Hive);

  await myHive.initFlutter();
  await myHive.openBoxes(['waterContainers', 'userData']);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterDisplayPage(),
      theme: Themes.dark,
    ),
  );
}
