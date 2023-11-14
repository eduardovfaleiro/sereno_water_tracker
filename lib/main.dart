// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'core/functions/add_listener_reminders.dart';
import 'core/initializers/get_it_initializer.dart';
import 'core/initializers/hive_initializer.dart';
import 'core/initializers/session_validator.dart';
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

@pragma("vm:entry-point")
onStart(ServiceInstance service) {
  print('');
  Timer.periodic(const Duration(seconds: 15), (timer) {});
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterBackgroundService().configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      notificationChannelId: '0',
    ),
  );

  GetItInitializer(getIt).initialize();

  await getIt<HiveInitializer>().initialize();
  await getIt<HiveInitializer>().registerAdapters();
  await getIt<HiveInitializer>().openBoxes();

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
      child: Sereno(await SessionValidator.check()),
    ),
  );
}

class Sereno extends StatefulWidget {
  final bool isSessionValid;

  const Sereno(this.isSessionValid, {Key? key}) : super(key: key);

  @override
  State<Sereno> createState() => SerenoState();
}

class SerenoState extends State<Sereno> {
  @override
  void initState() {
    super.initState();

    context.read<HomeController>().init();
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
