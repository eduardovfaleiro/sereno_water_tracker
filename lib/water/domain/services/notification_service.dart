import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

abstract class NotificationService {
  static const initializationSettings = InitializationSettings(android: AndroidInitializationSettings('sereno_icon'));

  static Future<void> initializeService() async {
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: (notificationResponse) => notificationTapBackground(notificationResponse),
    );

    await _configureLocalTimeZone();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> initializeReminders() async {}

  static Future<void> show() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Não se esqueça de beber água!',
      '200 ml',
      const NotificationDetails(android: AndroidNotificationDetails('channelId', 'channelName')),
    );
  }
}
