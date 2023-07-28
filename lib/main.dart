import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'core/theme/themes.dart';
import 'core/utils/init_functions/init_app.dart';
import 'water/presentation/view_models/user_view_model.dart';
import 'water/presentation/view_models/water_container_view_model.dart';
import 'water/presentation/view_models/water_view_model.dart';
import 'water/presentation/views/water/water_view.dart';
import 'water/presentation/views/water_form_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserEntityViewModel>(
          create: (_) => getIt<UserEntityViewModel>(),
        ),
        ChangeNotifierProvider<WaterViewModel>(
          create: (_) => getIt<WaterViewModel>(),
        ),
        ChangeNotifierProvider<WaterContainerViewModel>(
          create: (_) => getIt<WaterContainerViewModel>(),
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
        '/waterStarter': (context) => const WaterFormView(),
        '/waterDisplay': (_) => WaterView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
