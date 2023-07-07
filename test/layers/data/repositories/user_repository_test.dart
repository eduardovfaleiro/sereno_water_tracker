import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/sleep_time_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/wake_up_time_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weekly_workout_days_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weight_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/user_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/user_repository.dart';

class MockWeightDataSource extends Mock implements WeightDataSource {}

class MockWeeklyWorkoutDaysDataSource extends Mock implements WeeklyWorkoutDaysDataSource {}

class MockWakeUpTimeDataSource extends Mock implements WakeUpTimeDataSource {}

class MockSleepTimeDataSource extends Mock implements SleepTimeDataSource {}

void main() {
  late MockWeightDataSource mockWeightDataSource;
  late MockWeeklyWorkoutDaysDataSource mockWeeklyWorkoutDaysDataSource;
  late MockWakeUpTimeDataSource mockWakeUpTimeDataSource;
  late MockSleepTimeDataSource mockSleepTimeDataSource;
  late UserRepository repository;

  setUp(() {
    mockWeightDataSource = MockWeightDataSource();
    mockWeeklyWorkoutDaysDataSource = MockWeeklyWorkoutDaysDataSource();
    mockWakeUpTimeDataSource = MockWakeUpTimeDataSource();
    mockSleepTimeDataSource = MockSleepTimeDataSource();

    repository = UserRepositoryImp(
      mockWeightDataSource,
      mockWeeklyWorkoutDaysDataSource,
      mockWakeUpTimeDataSource,
      mockSleepTimeDataSource,
    );

    registerFallbackValue(const TimeOfDay(hour: 0, minute: 0));
  });

  group('updateSleepTime', () {
    TimeOfDay sleepTime = const TimeOfDay(hour: 22, minute: 0);

    test('Should update Sleepp time when call is successful', () async {
      // arrange
      when(() => mockSleepTimeDataSource.update(any())).thenAnswer((_) async {});

      // act
      var result = await repository.updateSleepTime(sleepTime);

      // assert
      verify(() => mockSleepTimeDataSource.update(sleepTime));
      expect(result, const Right(null));
    });

    // test('Should return CacheFailure when call fails', () async {
    //   // arrange
    //   when(() => mockSleepTimeDataSource.update(any())).thenThrow(CacheException());

    //   // act
    //   var result = await repository.updateSleepTime(sleepTime);
    //   var expectedResult = result.fold((failure) => failure, (_) {});

    //   // assert
    //   verify(() => mockSleepTimeDataSource.update(sleepTime));

    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });

  group('updateWakeUpTime', () {
    TimeOfDay wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should update wake up time when call is successful', () async {
      // arrange
      when(() => mockWakeUpTimeDataSource.update(any())).thenAnswer((_) async {});

      // act
      var result = await repository.updateWakeUpTime(wakeUpTime);

      // assert
      verify(() => mockWakeUpTimeDataSource.update(wakeUpTime));
      expect(result, const Right(null));
    });

    // test('Should return CacheFailure when call fails', () async {
    //   // arrange
    //   when(() => mockWakeUpTimeDataSource.update(any())).thenThrow(CacheException());

    //   // act
    //   var result = await repository.updateWakeUpTime(wakeUpTime);
    //   var expectedResult = result.fold((failure) => failure, (_) {});

    //   // assert
    //   verify(() => mockWakeUpTimeDataSource.update(wakeUpTime));

    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });

  group('updateWeeklyWorkoutDays', () {
    int weeklyWorkoutDays = 5;

    test('Should update weekly workout days when call is successful', () async {
      // arrange
      when(() => mockWeeklyWorkoutDaysDataSource.update(any())).thenAnswer((_) async {});

      // act
      var result = await repository.updateWeeklyWorkoutDays(weeklyWorkoutDays);

      // assert
      verify(() => mockWeeklyWorkoutDaysDataSource.update(weeklyWorkoutDays));
      expect(result, const Right(null));
    });

    // test('Should return CacheFailure when call fails', () async {
    //   // arrange
    //   when(() => mockWeeklyWorkoutDaysDataSource.update(any())).thenThrow(CacheException());

    //   // act
    //   var result = await repository.updateWeeklyWorkoutDays(weeklyWorkoutDays);
    //   var expectedResult = result.fold((failure) => failure, (_) {});

    //   // assert
    //   verify(() => mockWeeklyWorkoutDaysDataSource.update(weeklyWorkoutDays));

    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });

  group('updateWeight', () {
    int weight = 75;

    test('Should update weight when call is successful', () async {
      // arrange
      when(() => mockWeightDataSource.update(any())).thenAnswer((_) async {});

      // act
      var result = await repository.updateWeight(weight);

      // assert
      verify(() => mockWeightDataSource.update(weight));
      expect(result, const Right(null));
    });

    // test('Should return CacheFailure when call fails', () async {
    //   // arrange
    //   when(() => mockWeightDataSource.update(any())).thenThrow(CacheException());

    //   // act
    //   var result = await repository.updateWeight(weight);
    //   var expectedResult = result.fold((failure) => failure, (_) {});

    //   // assert
    //   verify(() => mockWeightDataSource.update(weight));

    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });
}
