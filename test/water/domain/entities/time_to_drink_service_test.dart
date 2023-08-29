import 'package:dart_date/dart_date.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/water_repository.dart';
import 'package:sereno_clean_architecture_solid/water/domain/services/time_to_drink_service.dart';
import 'package:clock/clock.dart';

class MockWaterRepository extends Mock implements WaterRepository {}

void main() {
  final mockWaterRepository = MockWaterRepository();
  final service = TimeToDrinkAgainServiceImp(mockWaterRepository);

  group('getNext', () {
    test('Should return the closest date (now the before)', () async {
      withClock(Clock.fixed(DateTime(2000).copyWith(hour: 23, minute: 55)), () async {
        List<TimeOfDay> timesToDrink = [
          const TimeOfDay(hour: 12, minute: 0),
          const TimeOfDay(hour: 13, minute: 15),
          const TimeOfDay(hour: 15, minute: 32),
          const TimeOfDay(hour: 1, minute: 0),
          const TimeOfDay(hour: 20, minute: 2),
        ];

        when(() => mockWaterRepository.getTimesToDrink()).thenAnswer((_) async => Right(timesToDrink));

        final result = await getResult(service.getNext());

        expect(result, DateTime(2000).addDays(1).copyWith(hour: 1, minute: 0));
      });
    });

    test('Should return the closest date (now the same)', () async {
      withClock(Clock.fixed(DateTime(1800, 2, 2).copyWith(hour: 20, minute: 2)), () async {
        List<TimeOfDay> timesToDrink = [
          const TimeOfDay(hour: 12, minute: 0),
          const TimeOfDay(hour: 13, minute: 15),
          const TimeOfDay(hour: 15, minute: 32),
          const TimeOfDay(hour: 1, minute: 0),
          const TimeOfDay(hour: 20, minute: 2),
        ];

        when(() => mockWaterRepository.getTimesToDrink()).thenAnswer((_) async => Right(timesToDrink));

        final result = await getResult(service.getNext());

        expect(result, DateTime(1800, 2, 3, 1));
      });
    });

    test('Should return the closest date (now after)', () async {
      withClock(Clock.fixed(DateTime(1800).copyWith(hour: 15, minute: 33)), () async {
        List<TimeOfDay> timesToDrink = [
          const TimeOfDay(hour: 12, minute: 0),
          const TimeOfDay(hour: 13, minute: 15),
          const TimeOfDay(hour: 15, minute: 32),
          const TimeOfDay(hour: 1, minute: 0),
          const TimeOfDay(hour: 20, minute: 2),
        ];

        when(() => mockWaterRepository.getTimesToDrink()).thenAnswer((_) async => Right(timesToDrink));

        final result = await getResult(service.getNext());

        expect(result, DateTime(1800).copyWith(hour: 20, minute: 2));
      });
    });
  });
}
