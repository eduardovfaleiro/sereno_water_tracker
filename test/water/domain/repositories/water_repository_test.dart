import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_water_tracker/core/core.dart';
import 'package:sereno_water_tracker/water/data/datasources/water_datasource.dart';
import 'package:sereno_water_tracker/water/data/repositories/water_repository.dart';

class MockWaterDataSource extends Mock implements WaterDataSource {}

void main() {
  final mockWaterDataSource = MockWaterDataSource();
  final repository = WaterRepositoryImp(mockWaterDataSource);

  group('setTimesToDrink', () {
    test('Should set times to drink', () async {
      final timesToDrink = [
        const TimeOfDay(hour: 10, minute: 0),
        const TimeOfDay(hour: 22, minute: 59),
      ];

      // arrange
      when(() => mockWaterDataSource.setTimesToDrink(any())).thenAnswer((invocation) async {});

      // act
      final result = await getResult(repository.setTimesToDrink(timesToDrink));

      // assert
      verify(() => mockWaterDataSource.setTimesToDrink(timesToDrink));

      expect(result, isInstanceOf<void>());
    });
  });
}
