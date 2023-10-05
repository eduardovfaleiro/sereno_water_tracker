import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../core/core.dart';
import '../../../main.dart';
import '../../data/repositories/water_repository.dart';
import '../../presentation/controllers/water_controller.dart';
import '../../presentation/utils/dialogs.dart';
import 'time_to_drink_service.dart';
import 'water_calculator_by_repository_service.dart';

final didReceiveLocalNotificationStream = StreamController<NotificationResponse>.broadcast();
final selectNotificationStream = StreamController<String?>.broadcast();

class NotificationService {
  final WaterCalculatorByRepositoryService _waterCalculatorByRepositoryService;
  final TimeToDrinkAgainService _timeToDrinkAgainService;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final initializationSettings =
      const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));

  NotificationService(
    this._waterCalculatorByRepositoryService,
    this._timeToDrinkAgainService,
    this.flutterLocalNotificationsPlugin,
  );

  Future<void> initialize() async {
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    await _requestPermission();
    await _configureLocalTimeZone();
  }

  Future<void> _requestPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> initializeReminders() async {
    DateTime? nextTimeScheduledToDrink;

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      var nextTimeToDrink = await getResult(_timeToDrinkAgainService.getNext());

      if (nextTimeToDrink is Failure) throw Exception();

      if (nextTimeScheduledToDrink != nextTimeToDrink) {
        var waterPerDrink = await getResult(
          _waterCalculatorByRepositoryService.calculateWaterPerDrinkByCustomReminders(),
        );

        if (waterPerDrink is Failure) throw Exception();

        await scheduleNotification(nextTimeToDrink, waterPerDrink);

        nextTimeScheduledToDrink = nextTimeToDrink;
      }
    });
  }

  Future<void> scheduleNotification(DateTime whenToNotify, int waterPerDrink) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      payload: jsonEncode({
        'drinking_reminder': waterPerDrink,
      }),
      'Não esqueça de beber água!',
      'Clique para beber $waterPerDrink ml rapidamente',
      tz.TZDateTime.from(
        whenToNotify,
        tz.getLocation(await FlutterTimezone.getLocalTimezone()),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          actions: [
            AndroidNotificationAction(
              ADD_WATER_ACTION_KEY,
              'Drink $waterPerDrink ml',
              showsUserInterface: true,
            ),
          ],
          'drinking_reminder',
          'Drinking reminder',
          channelDescription: 'Will remind you to drink water on a regular basis.',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void initializeStreams(BuildContext context) {
    didReceiveLocalNotificationStream.stream.listen((NotificationResponse notificationResponse) {
      _handleNotificationTap(context, notificationResponse.payload!);
    });

    selectNotificationStream.stream.listen((String? payload) async {
      _handleNotificationTap(context, payload!);
    });
  }

  void addIfNotificationStartedLaunch() async {
    var notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      didReceiveLocalNotificationStream.add(notificationAppLaunchDetails!.notificationResponse!);
    }
  }

  Future<void> _handleNotificationTap(BuildContext context, String payload) async {
    int amount = jsonDecode(payload)['drinking_reminder'];

    await Dialogs.confirm(
      title: 'Adicionar quantidade?',
      text: '$amount ml serão adicionados',
      context: navigatorKey.currentContext!,
      confirmText: 'Confirmar',
      cancelText: 'Cancelar',
      onYes: () async {
        await getIt<WaterRepository>().addDrankToday(amount);
        await context.read<WaterController>().init();

        navigatorKey.currentState!.pop(context);
      },
      onNo: () {
        navigatorKey.currentState!.pop(context);
      },
    );
  }
}
