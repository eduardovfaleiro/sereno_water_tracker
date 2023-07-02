import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/theme/themes.dart';
import 'core/utils/init_functions/init_app.dart';
import 'layers/presentation/view_models/user_view_model.dart';
import 'layers/presentation/view_models/water_display_view_model.dart';
import 'layers/presentation/views/water_display_view.dart';
import 'layers/presentation/views/water_starter_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WaterDisplayViewModel>(
          create: (_) => GetIt.I.get<WaterDisplayViewModel>(),
        ),
        ChangeNotifierProvider<UserEntityViewModel>(
          create: (_) => GetIt.I.get<UserEntityViewModel>(),
        ),
      ],
      child: const Sereno(),
    ),
  );
}

class Sereno extends StatelessWidget {
  const Sereno({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/waterStarter',
      routes: {
        '/waterStarter': (context) => const WaterStarterView(),
        '/waterDisplay': (_) => const WaterDisplayView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
