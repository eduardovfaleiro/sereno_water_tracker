import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/amount_of_water_drank_today_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_drinking_frequency_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_goal_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/get_daily_drinking_goal_completion_in_percentage_usecase.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/view_models/water_view_model.dart';

class MockDailyDrinkingGoalRepository extends Mock implements DailyDrinkingGoalRepository {}

class MockAmountOfWaterDrankTodayRepository extends Mock implements AmountOfWaterDrankTodayRepository {}

class MockNumberOfTimesToDrinkWaterDailyRepository extends Mock implements NumberOfTimesToDrinkWaterDailyRepository {}

class MockGetDailyDrinkingGoalCompletedPercentageUseCase extends Mock implements GetDailyDrinkingGoalCompletedPercentageUseCase {}

void main() {
  var mockNumberOfTimesToDrinkWaterDailyRepository = MockNumberOfTimesToDrinkWaterDailyRepository();
  var mockAmountOfWaterDrankTodayRepository = MockAmountOfWaterDrankTodayRepository();
  var mockDailyDrinkingGoalRepository = MockDailyDrinkingGoalRepository();
  var mockGetDailyDrinkingGoalCompletedPercentageUseCase = MockGetDailyDrinkingGoalCompletedPercentageUseCase();

  var viewModel = WaterViewModelImp(
    mockDailyDrinkingGoalRepository,
    mockNumberOfTimesToDrinkWaterDailyRepository,
    mockAmountOfWaterDrankTodayRepository,
    mockGetDailyDrinkingGoalCompletedPercentageUseCase,
  );

  group('getAmountDrankToday', () {
    int amountDrankToday = 1000;

    test('Should return amount of water drank today when successful', () async {
      // arrange
      when(() => mockAmountOfWaterDrankTodayRepository.get()).thenAnswer((_) async => Right(amountDrankToday));

      // act
      var result = await viewModel.getAmountDrankToday();

      // assert
      verify(() => mockAmountOfWaterDrankTodayRepository.get());
      verifyNoMoreInteractions(mockAmountOfWaterDrankTodayRepository);

      expect(result, Right(amountDrankToday));
    });
  });

  group('getDailyDrinkingGoal', () {
    int dailyDrinkingGoal = 3000;

    test('Should return daily water drinking goal when successful', () async {
      // arrange
      when(() => mockDailyDrinkingGoalRepository.get()).thenAnswer((_) async => Right(dailyDrinkingGoal));

      // act
      var result = await viewModel.getDailyDrinkingGoal();

      // assert
      verify(() => mockDailyDrinkingGoalRepository.get());
      verifyNoMoreInteractions(mockDailyDrinkingGoalRepository);

      expect(result, Right(dailyDrinkingGoal));
    });

    group('getNumberOfTimesToDrinkWaterDaily', () {
      int numberOfTimesToDrinkWaterDaily = 5;

      test('Should return the number of times the user must drink water a day', () async {
        // arrange
        when(() => mockNumberOfTimesToDrinkWaterDailyRepository.get()).thenAnswer((_) async => Right(numberOfTimesToDrinkWaterDaily));

        // act
        var result = await viewModel.getNumberOfTimesToDrinkDaily();

        // assert
        verify(() => mockNumberOfTimesToDrinkWaterDailyRepository.get());
        verifyNoMoreInteractions(mockNumberOfTimesToDrinkWaterDailyRepository);

        expect(result, Right(numberOfTimesToDrinkWaterDaily));
      });
    });
  });

  group('getDailyDrinkingGoalCompletedPercentageUseCase', () {
    double percentage = 0.25;

    test('Should return the daily drinking goal completed percentage', () async {
      // arrange
      when(() => mockGetDailyDrinkingGoalCompletedPercentageUseCase()).thenAnswer((_) async => Right(percentage));

      // act
      var result = await viewModel.getDailyGoalCompletedPercentage();

      // assert
      verify(() => mockGetDailyDrinkingGoalCompletedPercentageUseCase());
      verifyNoMoreInteractions(mockGetDailyDrinkingGoalCompletedPercentageUseCase);

      expect(result, Right(percentage));
    });
  });

  group('updateAmountDrankToday', () {});
}
