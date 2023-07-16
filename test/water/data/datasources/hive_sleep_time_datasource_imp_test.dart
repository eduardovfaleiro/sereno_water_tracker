import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/sleep_time_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;

  late SleepTimeDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveSleepTimeDataSourceImp(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
  });

  group('get', () {
    var sleepTime = const TimeOfDay(hour: 22, minute: 0);
    var sleepTimeString = '22:00';

    test('Should return call to get sleep time', () async {
      // arrange
      when(() => mockBox.get(any())).thenReturn(sleepTimeString);

      // act
      var result = await dataSource.get();

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.get(SLEEP_TIME),
      ]);

      expect(result, sleepTime);
    });
  });

  group('update', () {
    var sleepTime = const TimeOfDay(hour: 22, minute: 0);
    var sleepTimeString = '22:00';

    test('Should update call to update sleep time', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // act
      await dataSource.update(sleepTime);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(SLEEP_TIME, sleepTimeString),
      ]);
    });
  });
}
