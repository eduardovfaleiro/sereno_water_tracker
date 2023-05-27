import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'core/theme/themes.dart';
import 'core/utils/injection/inject.dart';
import 'core/utils/providers/providers.dart';
import 'layers/presentation/controllers/water_display_controller.dart';
import 'layers/presentation/ui/pages/display/water/water_display_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.init();

  var directory = await getApplicationDocumentsDirectory();

  // var myHive = MyHive(Hive);

  // await myHive.initFlutter();
  // await myHive.openBoxes(['waterContainers', 'userData']);

  runApp(
    Providers(
      [GetIt.I.get<WaterDisplayController>()],
      const SerenoCleanArchitectureSolid(),
    ).initAndReturnMultiProvider(),
  );
}

class SerenoCleanArchitectureSolid extends StatelessWidget {
  const SerenoCleanArchitectureSolid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterDisplayPage(),
      theme: Themes.dark,
    );
  }
}
