import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/amount_of_water_drank_today_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_goal_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/get_daily_drinking_goal_completion_in_percentage_usecase.dart';

class MockDailyDrinkingGoalRepository extends Mock implements DailyDrinkingGoalRepository {}

class MockAmountOfWaterDrankTodayRepository extends Mock implements AmountOfWaterDrankTodayRepository {}

void main() {
  var mockDailyDrinkingGoalRepository = MockDailyDrinkingGoalRepository();
  var mockAmountOfWaterDrankTodayRepository = MockAmountOfWaterDrankTodayRepository();

  var useCase = GetDailyDrinkingGoalCompletedPercentageUseCaseImp(
    mockDailyDrinkingGoalRepository,
    mockAmountOfWaterDrankTodayRepository,
  );

  test('Should return percentage drank today', () async {
    int dailyDrinkingGoal = 1000;
    int amountDrankToday = 250;
    double percentage = 0.25;

    // arrange
    when(() => mockDailyDrinkingGoalRepository.get()).thenAnswer((_) async => Right(dailyDrinkingGoal));
    when(() => mockAmountOfWaterDrankTodayRepository.get()).thenAnswer((_) async => Right(amountDrankToday));

    // act
    var result = await useCase();

    // assert
    verify(() => mockDailyDrinkingGoalRepository.get());
    verify(() => mockAmountOfWaterDrankTodayRepository.get());

    expect(result, Right(percentage));
  });
}
