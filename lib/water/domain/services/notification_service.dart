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
    await requestPermission();

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

    _initializeIsolateReceivePort();
    await scheduleNotifications();
  }

  Future<List<NotificationModel>> getNotifications() async {
    return _awesomeNotifications.listScheduledNotifications();
  }

  Future<void> requestPermission() async {
    await _awesomeNotifications.isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await _awesomeNotifications.requestPermissionToSendNotifications(
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
      await _createSingleNotification(
        id: idCount,
        time: time,
        amountPerDrink: amountPerDrink,
        localTimeZone: localTimeZone,
      );

      idCount++;
    }
  }

  Future<void> cancelAllNotifications() async {
    await _awesomeNotifications.cancelAll();
  }

  Future<void> cancelSchedule(int id) async {
    await _awesomeNotifications.cancelSchedule(id);
  }

  Future<void> createDefaultNotification(TimeOfDay time) async {
    List<NotificationModel> notifications = await _awesomeNotifications.listScheduledNotifications();
    int dailyGoal = await getResult(_waterRepository.getDailyDrinkingGoal());

    int remindersCount = await getResult(_waterRepository.getTimesToDrink()).then(
      (timesToDrink) => timesToDrink.length,
    );

    int amountPerDrink = _waterCalculatorService.calculateWaterPerDrinkByCustomReminders(dailyGoal, remindersCount);

    String localTimeZone = await _awesomeNotifications.getLocalTimeZoneIdentifier();

    int biggestId = -1;

    for (NotificationModel notification in notifications) {
      if (notification.content!.id! > biggestId) {
        biggestId = notification.content!.id!;
      }
    }

    int biggestIdAvailable = biggestId + 1;

    await _createSingleNotification(
      id: biggestIdAvailable,
      amountPerDrink: amountPerDrink,
      localTimeZone: localTimeZone,
      time: time,
    );
  }

  Future<void> _createSingleNotification({
    required int id,
    required TimeOfDay time,
    required int amountPerDrink,
    required String localTimeZone,
  }) {
    return _awesomeNotifications.createNotification(
      content: NotificationContent(
        category: NotificationCategory.Reminder,
        id: id,
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
