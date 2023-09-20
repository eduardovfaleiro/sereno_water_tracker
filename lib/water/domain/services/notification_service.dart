import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

abstract class NotificationService {
  static const initializationSettings = InitializationSettings(android: AndroidInitializationSettings('sereno-icon'));
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (_) {
        // ...
      },
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Brazil/SaoPaulo'));
  }
}
