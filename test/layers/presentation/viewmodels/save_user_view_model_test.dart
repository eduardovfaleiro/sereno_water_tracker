import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/view_models/save_user_view_model.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late SaveUserViewModel viewModel;

  setUp(() {
    mockUserRepository = MockUserRepository();
    viewModel = SaveUserViewModelImp(mockUserRepository);
  });

  group('updateWeight', () {
    double weight = 75;

    test('Should update the user\'s weight', () async {
      // arrange
      when(() => mockUserRepository.updateWeight(weight)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWeight(weight);

      // assert
      verify(() => mockUserRepository.updateWeight(weight));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWeight(weight)).thenAnswer((invocation) async => Left(CacheFailure()));

      // act
      var result = await viewModel.updateWeight(weight);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWeight(weight));
      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('updateWeeklyWorkoutDays', () {
    int weeklyWorkoutDays = 5;

    test('Should update the user\'s weekly workout days', () async {
      // arrange
      when(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWeeklyWorkoutDays(weeklyWorkoutDays);

      // assert
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays)).thenAnswer((invocation) async => Left(CacheFailure()));

      // act
      var result = await viewModel.updateWeeklyWorkoutDays(weeklyWorkoutDays);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWeeklyWorkoutDays(weeklyWorkoutDays));
      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('updateWakeUpTime', () {
    var wakeUpTime = const TimeOfDay(hour: 10, minute: 0);

    test('Should update the user\'s wake up time', () async {
      // arrange
      when(() => mockUserRepository.updateWakeUpTime(wakeUpTime)).thenAnswer((invocation) async => const Right(null));

      // act
      var result = await viewModel.updateWakeUpTime(wakeUpTime);

      // assert
      verify(() => mockUserRepository.updateWakeUpTime(wakeUpTime));
      expect(result, const Right(null));
    });

    test('Should return CacheFailure when call fails', () async {
      // arrange
      when(() => mockUserRepository.updateWakeUpTime(wakeUpTime)).thenAnswer((invocation) async => Left(CacheFailure()));

      // act
      var result = await viewModel.updateWakeUpTime(wakeUpTime);
      var expectedResult = result.fold((failure) => failure, (_) {});

      // assert
      verify(() => mockUserRepository.updateWakeUpTime(wakeUpTime));
      expect(expectedResult, isA<CacheFailure>());
    });

    group('updateSleepTime', () {
      var sleepTime = const TimeOfDay(hour: 10, minute: 0);

      test('Should update the user\'s sleeptime', () async {
        // arrange
        when(() => mockUserRepository.updateSleepTime(sleepTime)).thenAnswer((invocation) async => const Right(null));

        // act
        var result = await viewModel.updateSleepTime(sleepTime);

        // assert
        verify(() => mockUserRepository.updateSleepTime(sleepTime));
        expect(result, const Right(null));
      });

      test('Should return CacheFailure when call fails', () async {
        // arrange
        when(() => mockUserRepository.updateSleepTime(sleepTime)).thenAnswer((invocation) async => Left(CacheFailure()));

        // act
        var result = await viewModel.updateSleepTime(sleepTime);
        var expectedResult = result.fold((failure) => failure, (_) {});

        // assert
        verify(() => mockUserRepository.updateSleepTime(sleepTime));
        expect(expectedResult, isA<CacheFailure>());
      });
    });
  });
}
