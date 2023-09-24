import 'dart:async';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../core/core.dart';
import '../../../core/theme/themes.dart';
import '../../../main.dart';
import 'time_to_drink_service.dart';

abstract class NotificationService {
  static late final TimeToDrinkAgainService _timeToDrinkAgainService;

  static const initializationSettings =
      InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));

  static Future<void> initializeService() async {
    // TODO: fix this shit
    _timeToDrinkAgainService = getIt<TimeToDrinkAgainService>();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: (notificationResponse) => notificationTapBackground(notificationResponse),
    );

    await _requestPermission();
    await _configureLocalTimeZone();
  }

  static Future<void> _requestPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> initializeReminders() async {
    DateTime? nextTimeScheduledToDrink;

    Timer.periodic(const Duration(seconds: 30), (timer) async {
      var nextTimeToDrinkResult = await getResult(_timeToDrinkAgainService.getNext());

      if (nextTimeToDrinkResult is Failure) throw Exception();

      if (nextTimeScheduledToDrink != nextTimeToDrinkResult) {
        await _scheduleNotification(nextTimeToDrinkResult);

        nextTimeScheduledToDrink = nextTimeToDrinkResult;
      }
    });
  }

  static Future<void> _scheduleNotification(DateTime whenToNotify) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Não esqueça de beber água!',
      'Clique para beber 440 ml rapidamente',
      tz.TZDateTime.from(
        whenToNotify,
        tz.getLocation(await FlutterTimezone.getLocalTimezone()),
      ),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        actions: [
          AndroidNotificationAction('id', 'title'),
        ],
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      )),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> show() async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: [
        AndroidNotificationAction('id', 'Beber 440 ml', titleColor: MyColors.lightBlue),
      ],
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Não se esqueça de beber água!',
      'Clique para beber 440 ml rapidamente',
      notificationDetails,
    );
  }
}
