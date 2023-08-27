import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_datasource.dart';

import '../../../mocks.dart';

void main() {
  final mockHiveInterface = MockHiveInterface();
  final mockBox = MockBox();

  final dataSource = HiveWaterDataSource(mockHiveInterface);

  group('deleteTimeToDrink', () {
    const timeToDrink = TimeOfDay(hour: 0, minute: 0);

    test('Should make call for hive to delete time to drink', () async {
      // arrange
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      // act
      await dataSource.deleteTimeToDrink(timeToDrink);

      // assert
      verify(() => mockHiveInterface.box(WATER));
      verify(() => mockBox.delete(timeToDrink));
    });
  });
}
