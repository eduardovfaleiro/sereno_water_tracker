import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'core/core.dart';
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
import 'water/presentation/views/water_form/pages/finish_water_form.dart';
import 'water/presentation/views/water_settings/water_settings_view.dart';
import 'water/presentation/views/water/water_view.dart';
import 'water/presentation/views/water_form/water_form_view.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) async {
  // const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //   '...',
  //   '...',
  //   actions: <AndroidNotificationAction>[
  //     AndroidNotificationAction('id_1', 'Action 1'),
  //     AndroidNotificationAction('id_2', 'Action 2'),
  //     AndroidNotificationAction('id_3', 'Action 3'),
  //   ],
  // );

  // const NotificationDetails notificationDetails = NotificationDetails();
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGetIt();
  await initHive();

  getIt<ResetDataWithTimerService>().startWater();
  bool isSessionValid = await validateSession();

  await NotificationService.initializeService();
  await NotificationService.initializeReminders();

  await NotificationService.show();

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
