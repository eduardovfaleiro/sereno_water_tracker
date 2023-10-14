import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_water_tracker/core/core.dart';
import 'package:sereno_water_tracker/water/data/datasources/water_datasource.dart';

import '../../../mocks.dart';

void main() {
  final mockHiveInterface = MockHiveInterface();
  final mockBox = MockBox();

  final dataSource = HiveWaterDataSource(mockHiveInterface);

  group('deleteTimeToDrink', () {
    const timeToDrink = TimeOfDay(hour: 10, minute: 0);

    List<String> timesToDrink = ['00:00', '10:00', '13:30'];

    test('Should make call for hive to delete time to drink', () async {
      // arrange
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.get(any())).thenReturn(timesToDrink);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // act
      await dataSource.deleteTimeToDrink(timeToDrink);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(WATER),
        () => mockBox.get(TIMES_TO_DRINK),
        () => mockBox.put(TIMES_TO_DRINK, ['00:00', '13:30']),
      ]);
    });
  });

  group('updateTimeToDrink', () {
    List<String> timesToDrink = ['11:30', '00:00', '9:00'];

    test('Should update the time to drink accordingly to the key passed', () async {
      // arrange
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.get(any())).thenReturn(timesToDrink);

      // act
      await dataSource.updateTimeToDrink(
        const TimeOfDay(hour: 0, minute: 0),
        const TimeOfDay(hour: 16, minute: 0),
      );

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(WATER),
        () => mockBox.get(TIMES_TO_DRINK),
      ]);
    });
  });
}
