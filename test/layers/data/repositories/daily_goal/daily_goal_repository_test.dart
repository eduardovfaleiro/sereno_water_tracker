// ignore_for_file: void_checks

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/error/exceptions.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal/daily_goal_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/daily_goal_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_goal_repository.dart';

import 'daily_goal_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyGoalDataSource>()])
void main() {
  late MockDailyGoalDataSource mockDailyGoalDataSource;
  late DailyGoalRepository repository;

  setUp(() {
    mockDailyGoalDataSource = MockDailyGoalDataSource();
    repository = DailyGoalRepositoryImp(mockDailyGoalDataSource);
  });

  group('create', () {
    int amount = 1000;

    test('Should make the call for the datasource successfuly', () async {
      await repository.create(amount);

      verify(mockDailyGoalDataSource.create(amount));
    });
    test('Should make the call for the datasource fails', () async {
      when(mockDailyGoalDataSource.create(any)).thenThrow(CacheException());

      var result = await repository.create(amount);
      var expectedResult = result.fold((l) => l, (r) => null);

      verify(mockDailyGoalDataSource.create(amount));
      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('get', () {
    int amount = 1000;

    test('Should return the amount of water drank today when call to datasource is successful', () async {
      when(mockDailyGoalDataSource.get()).thenAnswer((_) async => amount);

      var result = await repository.get();

      verify(mockDailyGoalDataSource.get());
      expect(result, Right(amount));
    });

    test('Should return CacheFailure when call to datasource fails', () async {
      when(mockDailyGoalDataSource.get()).thenThrow(CacheException());

      var result = await repository.get();
      var expectedResult = result.fold((l) => l, (r) => null);

      verify(mockDailyGoalDataSource.get());
      expect(expectedResult, isA<CacheFailure>());
    });
  });
}
