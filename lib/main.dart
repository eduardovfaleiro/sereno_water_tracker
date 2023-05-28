import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/theme/themes.dart';
import 'core/utils/functions/init_app.dart';
import 'layers/presentation/controllers/water_display_controller.dart';
import 'layers/presentation/ui/pages/display/water/water_display_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WaterDisplayController>(
          create: (_) => GetIt.I.get<WaterDisplayController>(),
        ),
      ],
      child: const SerenoCleanArchitectureSolid(),
    ),
  );
}

class SerenoCleanArchitectureSolid extends StatelessWidget {
  const SerenoCleanArchitectureSolid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WaterDisplayPage(),
      theme: Themes.dark,
    );
  }
}
