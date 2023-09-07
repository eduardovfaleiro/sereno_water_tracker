import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/functions/validate_session.dart';
import 'core/init_functions/init_get_it.dart';
import 'core/init_functions/init_hive.dart';
import 'core/theme/themes.dart';
import 'water/domain/services/reset_data_with_timer_service.dart';
import 'water/presentation/controllers/home_controller.dart';
import 'water/presentation/controllers/reminder_controller.dart';
import 'water/presentation/controllers/water_container_controller.dart';
import 'water/presentation/controllers/water_controller.dart';
import 'water/presentation/controllers/water_form_controller.dart';

import 'core/core.dart';
import 'water/presentation/controllers/water_settings_controller.dart';
import 'water/presentation/views/home/home_view.dart';
import 'water/presentation/views/water_settings/water_settings_view.dart';
import 'water/presentation/views/water/water_view.dart';
import 'water/presentation/views/water_form/water_form_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGetIt();
  await initHive();

  getIt<ResetDataWithTimerService>().startWater();
  bool isSessionValid = await validateSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WaterFormController>(
          create: (context) => getIt<WaterFormController>(),
        ),
        ChangeNotifierProvider<WaterController>(
          create: (context) => getIt<WaterController>(),
        ),
        ChangeNotifierProvider<WaterContainerController>(
          create: (context) => getIt<WaterContainerController>(),
        ),
        ChangeNotifierProvider<WaterSettingsController>(
          create: (context) => getIt<WaterSettingsController>(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => getIt<HomeController>(),
        ),
        ChangeNotifierProvider<ReminderController>(
          create: (context) => getIt<ReminderController>(),
        ),
      ],
      child: SerenoView(isSessionValid: isSessionValid),
    ),
  );
}

class SerenoView extends StatelessWidget {
  final bool isSessionValid;

  const SerenoView({super.key, required this.isSessionValid});

  String get initialRoute => isSessionValid ? '/home' : '/waterForm';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/waterForm': (context) => const WaterFormView(),
        '/water': (_) => const WaterView(),
        '/home': (_) => const HomeView(),
        '/waterSettings': (_) => const WaterSettingsView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
