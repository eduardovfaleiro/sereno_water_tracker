import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/theme/themes.dart';
import '../../../main.dart';
import '../../data/repositories/water_repository.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<void> requestPermission();
  Future<void> scheduleNotification();
}

class NotificationServiceImp implements NotificationService {
  final AwesomeNotifications _awesomeNotifications;
  final WaterRepository _waterRepository;

  NotificationServiceImp(this._awesomeNotifications, this._waterRepository);

  ReceivedAction? _initialAction;
  ReceivePort? _receivePort;

  Future<void> _initializeIsolateReceivePort() async {
    _receivePort = ReceivePort('Notification action port in main isolate')
      ..listen((silentData) => onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(_receivePort!.sendPort, 'notification_action_port');
  }

  Future<void> onActionReceivedImplementationMethod(ReceivedAction receivedAction) async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/home',
      (route) => (route.settings.name != '/home') || route.isFirst,
      arguments: receivedAction,
    );
  }

  @override
  Future<void> initialize() async {
    await _awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'drinking_reminder',
          channelName: 'Drinking reminder',
          channelDescription: 'Reminders to drink water',
          defaultColor: MyColors.lightBlue,
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );

    _initialAction = await _awesomeNotifications.getInitialNotificationAction();

    await requestPermission();

    await _awesomeNotifications.cancelAll();
    await _scheduleNotifications();
  }

  Future<void> _scheduleNotifications() async {
    int idCount = 0;

    String localTimeZone = await _awesomeNotifications.getLocalTimeZoneIdentifier();
    List<TimeOfDay> timesToDrink = await getResult(_waterRepository.getTimesToDrink());

    for (TimeOfDay time in timesToDrink) {
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          category: NotificationCategory.Reminder,
          id: idCount,
          actionType: ActionType.SilentBackgroundAction,
          channelKey: 'drinking_reminder',
          title: 'Não esqueça de beber água!',
          body: 'Clique aqui para rapidamente beber 440ml',
        ),
        schedule: NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          timeZone: localTimeZone,
          repeats: true,
          allowWhileIdle: true,
        ),
      );

      idCount++;
    }
  }

  @override
  Future<void> requestPermission() async {
    await _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        _awesomeNotifications.requestPermissionToSendNotifications(
          permissions: [NotificationPermission.PreciseAlarms],
        );
      }
    });
  }

  @override
  Future<void> scheduleNotification() async {
    String localTimeZone = await _awesomeNotifications.getLocalTimeZoneIdentifier();

    _awesomeNotifications.createNotification(
      content: NotificationContent(
        category: NotificationCategory.Reminder,
        id: 0,
        channelKey: 'drinking_reminder',
        title: 'Não esqueça de beber água!',
        body: 'Clique aqui para rapidamente beber 440ml',
      ),
      schedule: NotificationCalendar(
        hour: 21,
        minute: 36,
        second: 0,
        timeZone: localTimeZone,
        repeats: true,
        allowWhileIdle: true,
      ),
    );
  }
}

@pragma("vm:entry-point")
Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {}

@pragma("vm:entry-point")
Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {}

@pragma("vm:entry-point")
Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}

  // Future<void> initializeReminders() async {
  //   DateTime? nextTimeScheduledToDrink;

  //   Timer.periodic(const Duration(seconds: 5), (timer) async {
  //     var nextTimeToDrink = await getResult(_timeToDrinkAgainService.getNext());

  //     if (nextTimeToDrink is Failure) throw Exception();

  //     if (nextTimeScheduledToDrink != nextTimeToDrink) {
  //       var waterPerDrink = await getResult(
  //         _waterCalculatorByRepositoryService.calculateWaterPerDrinkByCustomReminders(),
  //       );

  //       if (waterPerDrink is Failure) throw Exception();

  //       await scheduleNotification(nextTimeToDrink, waterPerDrink);

  //       nextTimeScheduledToDrink = nextTimeToDrink;
  //     }
  //   });
  // }


  // Future<void> scheduleNotification(DateTime whenToNotify, int waterPerDrink) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0,
  //     payload: jsonEncode({
  //       'drinking_reminder': waterPerDrink,
  //     }),
  //     'Não esqueça de beber água!',
  //     'Clique para beber $waterPerDrink ml rapidamente',
  //     tz.TZDateTime.from(
  //       whenToNotify,
  //       tz.getLocation(await FlutterTimezone.getLocalTimezone()),
  //     ),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         actions: [
  //           AndroidNotificationAction(
  //             ADD_WATER_ACTION_KEY,
  //             'Drink $waterPerDrink ml',
  //             showsUserInterface: true,
  //           ),
  //         ],
  //         'drinking_reminder',
  //         'Drinking reminder',
  //         channelDescription: 'Will remind you to drink water on a regular basis.',
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  // Future<void> _handleNotificationTap(BuildContext context, String payload) async {
  //   int amount = jsonDecode(payload)['drinking_reminder'];

  //   await Dialogs.confirm(
  //     title: 'Adicionar quantidade?',
  //     text: '$amount ml serão adicionados',
  //     context: navigatorKey.currentContext!,
  //     confirmText: 'Confirmar',
  //     cancelText: 'Cancelar',
  //     onYes: () async {
  //       await getIt<WaterRepository>().addDrankToday(amount);
  //       await context.read<WaterController>().init();

  //       navigatorKey.currentState!.pop(context);
  //     },
  //     onNo: () {
  //       navigatorKey.currentState!.pop(context);
  //     },
  //   );
  // }