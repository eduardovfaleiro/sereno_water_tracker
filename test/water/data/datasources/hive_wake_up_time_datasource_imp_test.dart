import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/wake_up_time_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;

  late WakeUpTimeDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWakeUpTimeDataSourceImp(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
  });

  group('get', () {
    var wakeUpTime = const TimeOfDay(hour: 10, minute: 0);
    var wakeUpTimeString = '10:00';

    test('Should return call to get wake up time', () async {
      // arrange
      when(() => mockBox.get(any())).thenReturn(wakeUpTimeString);

      // act
      var result = await dataSource.get();

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.get(WAKE_UP_TIME),
      ]);

      expect(result, wakeUpTime);
    });
  });

  group('update', () {
    var wakeUpTime = const TimeOfDay(hour: 10, minute: 0);
    var wakeUpTimeString = '10:00';

    test('Should update call to update wake up time', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // act
      await dataSource.update(wakeUpTime);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WAKE_UP_TIME, wakeUpTimeString),
      ]);
    });
  });
}
