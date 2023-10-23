// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'core/functions/add_listener_reminders.dart';
import 'core/functions/validate_session.dart';
import 'core/initializers/get_it_initializer.dart';
import 'core/initializers/hive_initializer.dart';
import 'core/initializers/session_valid.dart';
import 'core/theme/themes.dart';
import 'water/domain/services/notification_service.dart';
import 'water/domain/services/reset_data_with_timer_service.dart';
import 'water/presentation/controllers/home_controller.dart';
import 'water/presentation/controllers/reminder_controller.dart';
import 'water/presentation/controllers/water_container_controller.dart';
import 'water/presentation/controllers/water_controller.dart';
import 'water/presentation/controllers/water_form_controller.dart';
import 'water/presentation/controllers/water_settings_controller.dart';
import 'water/presentation/views/home/home_view.dart';
import 'water/presentation/views/water/water_view.dart';
import 'water/presentation/views/water_form/pages/finish_water_form.dart';
import 'water/presentation/views/water_form/water_form_view.dart';
import 'water/presentation/views/water_settings/water_settings_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> initializeApp() async {
  GetItInitializer(getIt).initialize();

  await getIt<HiveInitializer>().initialize();
  await getIt<HiveInitializer>().openBoxes();

  if (await SessionValid.check()) {
    await getIt<HiveInitializer>().registerAdapters();
    await getIt<HiveInitializer>().startDrinkHistoryReset();
    await getIt<HiveInitializer>().generateContainersIfEmpty();

    getIt<ResetDataWithTimerService>().startWater();
    await getIt<NotificationService>().initialize();

    await getIt<HiveInitializer>().setListenersReminders();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

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
      child: Sereno(
        isSessionValid: await validateSession(),
      ),
    ),
  );
}

class Sereno extends StatefulWidget {
  final bool isSessionValid;

  const Sereno({
    Key? key,
    required this.isSessionValid,
  }) : super(key: key);

  @override
  State<Sereno> createState() => SerenoState();
}

class SerenoState extends State<Sereno> {
  @override
  void initState() {
    super.initState();

    getIt<NotificationService>().setListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: widget.isSessionValid ? '/home' : '/waterForm',
      navigatorKey: navigatorKey,
      routes: {
        '/waterForm': (context) => const WaterFormView(),
        '/finishWaterForm': (context) => const FinishWaterForm(),
        '/waterSettings': (_) => const WaterSettingsView(),
        '/water': (_) => const WaterView(),
        '/home': (_) => const HomeView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
