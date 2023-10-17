import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/theme/themes.dart';
import '../../../main.dart';
import '../../data/repositories/water_repository.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/water_controller.dart';
import '../../presentation/views/water/water_view.dart';
import 'water_calculator_service.dart';

class NotificationService {
  final AwesomeNotifications _awesomeNotifications;
  final WaterRepository _waterRepository;
  final WaterCalculatorService _waterCalculatorService;

  NotificationService(
    this._awesomeNotifications,
    this._waterRepository,
    this._waterCalculatorService,
  );

  static ReceivedAction? initialAction;
  static ReceivePort? _receivePort;

  Future<void> initialize() async {
    await _awesomeNotifications.initialize(
      'resource://drawable/launcher_icon',
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

    await _requestPermission();
    _initializeIsolateReceivePort();
    await scheduleNotifications();
  }

  Future<void> _requestPermission() async {
    await _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        _awesomeNotifications.requestPermissionToSendNotifications(
          permissions: [NotificationPermission.PreciseAlarms],
        );
      }
    });
  }

  Future<void> _initializeIsolateReceivePort() async {
    _receivePort = ReceivePort('Notification action port in main isolate')
      ..listen((silentData) => onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(_receivePort!.sendPort, 'notification_action_port');
  }

  Future<void> initializeInitialAction() async {
    initialAction = await _awesomeNotifications.getInitialNotificationAction();
  }

  Future<void> setListeners() async {
    _awesomeNotifications.setListeners(
      onActionReceivedMethod: NotificationService.onActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedImplementationMethod(ReceivedAction receivedAction) async {
    navigatorKey.currentContext?.read<WaterController>().onLaunchAction = AddWaterAction(
      int.parse(receivedAction.payload!['amount']!),
    );

    navigatorKey.currentContext?.read<HomeController>().selectedPage = 0;

    await navigatorKey.currentState?.pushNamedAndRemoveUntil('/home', (route) => true);
  }

  Future<void> scheduleNotifications() async {
    int idCount = 0;

    int dailyGoal = await getResult(_waterRepository.getDailyDrinkingGoal());

    int remindersCount = await getResult(_waterRepository.getTimesToDrink()).then(
      (timesToDrink) => timesToDrink.length,
    );

    int amountPerDrink = _waterCalculatorService.calculateWaterPerDrinkByCustomReminders(dailyGoal, remindersCount);

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
          body: 'Clique aqui para rapidamente beber ${amountPerDrink}ml',
          payload: {'amount': '$amountPerDrink'},
        ),
        schedule: NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          timeZone: localTimeZone,
          repeats: true,
          allowWhileIdle: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'Beber',
            label: 'Beber',
          ),
        ],
      );

      idCount++;
    }
  }

  // Future<void> scheduleNotification() async {
  //   String localTimeZone = await _awesomeNotifications.getLocalTimeZoneIdentifier();

  //   await _awesomeNotifications.createNotification(
  //     content: NotificationContent(
  //       category: NotificationCategory.Reminder,
  //       id: 0,
  //       actionType: ActionType.SilentBackgroundAction,
  //       channelKey: 'drinking_reminder',
  //       title: 'Não esqueça de beber água!',
  //       body: 'Clique aqui para rapidamente beber 440ml',
  //     ),
  //     schedule: NotificationCalendar(
  //       hour: DateTime.now().hour,
  //       minute: DateTime.now().minute + 1,
  //       timeZone: localTimeZone,
  //       repeats: true,
  //       allowWhileIdle: true,
  //     ),
  //     actionButtons: [
  //       NotificationActionButton(
  //         key: 'Beber',
  //         label: 'Beber',
  //       ),
  //     ],
  //   );
  // }

  Future<void> cancelAllNotifications() async {
    await _awesomeNotifications.cancelAll();
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    await getIt<NotificationService>().initializeInitialAction();

    if (_receivePort == null) {
      SendPort? sendPort = IsolateNameServer.lookupPortByName('notification_action_port');

      if (sendPort != null) {
        sendPort.send(receivedAction);
        return;
      }
    }

    return onActionReceivedImplementationMethod(receivedAction);
  }
}




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