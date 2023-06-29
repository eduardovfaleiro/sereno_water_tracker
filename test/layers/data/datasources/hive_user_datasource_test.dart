import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/user_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;

  late UserDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveUserDataSourceImp(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
    when(() => mockBox.put(any(), any())).thenAnswer((_) async {});
  });

  group('updateSleepTime', () {
    var sleepTime = const TimeOfDay(hour: 22, minute: 0);

    test('Should make call for database to update sleeptime', () async {
      await dataSource.updateSleepTime(sleepTime);

      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(SLEEP_TIME, sleepTime),
      ]);
    });
  });

  group('updateWakeUpTime', () {
    var wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should make call for database to update wake up time', () async {
      await dataSource.updateWakeUpTime(wakeUpTime);

      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WAKE_UP_TIME, wakeUpTime),
      ]);
    });
  });

  group('updateWeeklyWorkoutDays', () {
    int weeklyWorkoutDays = 4;

    test(
        'Should make call for database to update the '
        'number of days the user works out a week', () async {
      await dataSource.updateWeeklyWorkoutDays(weeklyWorkoutDays);

      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WEEKLY_WORKOUT_DAYS, weeklyWorkoutDays),
      ]);
    });
  });

  group('updateWeight', () {
    double weight = 75;

    test('Should make call for database to update the user\'s weight', () async {
      await dataSource.updateWeight(weight);

      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WEIGHT, weight),
      ]);
    });
  });
}
