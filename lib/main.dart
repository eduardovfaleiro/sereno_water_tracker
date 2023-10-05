import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'core/core.dart';
import 'core/functions/validate_session.dart';
import 'core/init_functions/init_get_it.dart';
import 'core/init_functions/init_hive.dart';
import 'core/theme/themes.dart';

import 'water/domain/services/notification_service.dart';
import 'water/domain/services/reset_data_with_timer_service.dart';
import 'water/domain/services/time_to_drink_service.dart';
import 'water/domain/services/water_calculator_by_repository_service.dart';
import 'water/presentation/controllers/home_controller.dart';
import 'water/presentation/controllers/reminder_controller.dart';
import 'water/presentation/controllers/water_container_controller.dart';
import 'water/presentation/controllers/water_controller.dart';
import 'water/presentation/controllers/water_form_controller.dart';
import 'water/presentation/controllers/water_settings_controller.dart';
import 'water/presentation/views/home/home_view.dart';
import 'water/presentation/views/water_form/pages/finish_water_form.dart';
import 'water/presentation/views/water_settings/water_settings_view.dart';
import 'water/presentation/views/water/water_view.dart';
import 'water/presentation/views/water_form/water_form_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  didReceiveLocalNotificationStream.add(notificationResponse);
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    DateTime? lastTimeScheduled;

    var calculateWaterPerDrinkByCustomRemindersResult =
        await getResult(getIt<WaterCalculatorByRepositoryService>().calculateWaterPerDrinkByCustomReminders());
    int waterPerDrink = calculateWaterPerDrinkByCustomRemindersResult;

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      var getNextResult = await getResult(getIt<TimeToDrinkAgainService>().getNext());
      var nextTimeToDrink = getNextResult as DateTime;

      if (lastTimeScheduled == null) {
        await getIt<NotificationService>().scheduleNotification(nextTimeToDrink, waterPerDrink).then((_) {
          lastTimeScheduled = nextTimeToDrink.copyWith();
        });
      } else if (lastTimeScheduled!.isBefore(DateTime.now())) {
        await getIt<NotificationService>().scheduleNotification(nextTimeToDrink, waterPerDrink).then((_) {
          lastTimeScheduled = nextTimeToDrink.copyWith();
        });
      }
    });

    return true;
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );

  Workmanager().registerOneOffTask("task-identifier", "simpleTask");

  await initGetIt();
  await initHive();

  getIt<ResetDataWithTimerService>().startWater();

  await getIt<NotificationService>().initialize();
  await getIt<NotificationService>().initializeReminders();

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
      child: SerenoView(
        isSessionValid: await validateSession(),
        notificationService: getIt<NotificationService>(),
      ),
    ),
  );
}

class SerenoView extends StatefulWidget {
  final bool isSessionValid;
  final NotificationService notificationService;

  const SerenoView({super.key, required this.isSessionValid, required this.notificationService});

  @override
  State<SerenoView> createState() => SerenoViewState();
}

class SerenoViewState extends State<SerenoView> {
  @override
  void initState() {
    super.initState();

    widget.notificationService.initializeStreams(context);
    widget.notificationService.addIfNotificationStartedLaunch();
  }

  String get initialRoute => widget.isSessionValid ? '/home' : '/waterForm';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      navigatorKey: navigatorKey,
      routes: {
        '/waterForm': (context) => const WaterFormView(),
        '/finishWaterForm': (context) => const FinishWaterForm(),
        '/water': (_) => const WaterView(),
        '/home': (_) => const HomeView(),
        '/waterSettings': (_) => const WaterSettingsView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
