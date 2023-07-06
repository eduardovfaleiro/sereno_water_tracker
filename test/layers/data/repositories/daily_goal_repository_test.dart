// ignore_for_file: void_checks

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/daily_goal_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_goal_repository.dart';

class MockDailyDrinkingGoalDataSource extends Mock implements DailyDrinkingGoalDataSource {}

void main() {
  late MockDailyDrinkingGoalDataSource mockDailyDrinkingGoalDataSource;
  late DailyDrinkingGoalRepository repository;

  setUp(() {
    mockDailyDrinkingGoalDataSource = MockDailyDrinkingGoalDataSource();
    repository = DailyDrinkingGoalRepositoryImp(mockDailyDrinkingGoalDataSource);
  });

  group('get', () {
    int amount = 1000;

    test('Should return the amount of water drank today when call to datasource is successful', () async {
      when(() => mockDailyDrinkingGoalDataSource.get()).thenAnswer((_) async => amount);

      var result = await repository.get();

      verify(() => mockDailyDrinkingGoalDataSource.get());
      expect(result, Right(amount));
    });

    // test('Should return CacheFailure when call to datasource fails', () async {
    //   when(() => mockDailyDrinkingGoalDataSource.get()).thenThrow(CacheException());

    //   var result = await repository.get();
    //   var expectedResult = result.fold((l) => l, (r) => null);

    //   verify(() => mockDailyDrinkingGoalDataSource.get());
    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });
}
