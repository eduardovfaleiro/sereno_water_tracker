import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/water_repository.dart';

class MockWaterDataSource extends Mock implements WaterDataSource {}

void main() {
  final mockWaterDataSource = MockWaterDataSource();
  final repository = WaterRepositoryImp(mockWaterDataSource);

  setUpAll(() {
    registerFallbackValue(const TimeOfDay(hour: 0, minute: 0));
  });

  group('deleteTimeToDrink', () {
    const timeToDrink = TimeOfDay(hour: 0, minute: 0);

    test('Should make call to delete time to drink', () async {
      // arrange
      when(() => mockWaterDataSource.deleteTimeToDrink(any())).thenAnswer((_) async {});

      // act
      var result = await repository.deleteTimeToDrink(timeToDrink);

      // assert
      verify(() => mockWaterDataSource.deleteTimeToDrink(timeToDrink));
      expect(result, const Right(null));
    });
  });
}
