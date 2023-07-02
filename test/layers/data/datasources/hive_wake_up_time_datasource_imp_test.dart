import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/wake_up_time_datasource.dart';

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
    TimeOfDay wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should return call to get wake up time', () async {
      // arrange
      when(() => mockBox.get(any())).thenAnswer((invocation) async => wakeUpTime);

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
    TimeOfDay wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should update call to update wake up time', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenAnswer((invocation) async {});

      // act
      await dataSource.update(wakeUpTime);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WAKE_UP_TIME, wakeUpTime),
      ]);
    });
  });
}
