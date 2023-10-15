// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'core/functions/add_listener_reminders.dart';
import 'core/functions/validate_session.dart';
import 'core/init_functions/init_get_it.dart';
import 'core/init_functions/init_hive.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGetIt();
  await initHive();

  bool isSessionValid = await validateSession();

  if (isSessionValid) {
    getIt<ResetDataWithTimerService>().startWater();
    await getIt<NotificationService>().initialize();

    addListenerReminders(() async {
      await getIt<NotificationService>().cancelAllNotifications();
      await getIt<NotificationService>().scheduleNotifications();
    });
  }

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
        navigatorKey: navigatorKey,
        isSessionValid: isSessionValid,
        notificationService: getIt<NotificationService>(),
      ),
    ),
  );
}

class Sereno extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final bool isSessionValid;
  final NotificationService notificationService;

  const Sereno({
    Key? key,
    required this.navigatorKey,
    required this.isSessionValid,
    required this.notificationService,
  }) : super(key: key);

  @override
  State<Sereno> createState() => SerenoState();
}

class SerenoState extends State<Sereno> {
  @override
  void initState() {
    super.initState();

    widget.notificationService.setListeners();
  }

  String get initialRoute {
    if (widget.isSessionValid) {
      return '/home';
    }

    return '/waterForm';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      navigatorKey: navigatorKey,
      routes: {
        // Water
        '/waterForm': (context) => const WaterFormView(),
        '/finishWaterForm': (context) => const FinishWaterForm(),
        '/waterSettings': (_) => const WaterSettingsView(),
        '/water': (_) => const WaterView(),

        // Home
        '/home': (_) => const HomeView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
