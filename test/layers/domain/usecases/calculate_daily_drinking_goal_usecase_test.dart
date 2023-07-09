import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/user_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/calculate_daily_drinking_goal_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  var mockUserRepository = MockUserRepository();
  var useCase = CalculateDailyDrinkingGoalUseCaseImp(mockUserRepository);

  test('Should return the correct daily drinking goal', () async {
    int weight = 75;
    int weeklyWorkoutDays = 5;
    int mlPerKg = 35;
    int mlPerWorkout = 500;
    const daysPerWeek = 7;

    double dailyDrinkingGoal = weight * mlPerKg + ((mlPerWorkout * weeklyWorkoutDays) / daysPerWeek);

    // arrange
    when(() => mockUserRepository.getWeight()).thenAnswer((_) async => Right(weight));
    when(() => mockUserRepository.getWeeklyWorkoutDays()).thenAnswer((_) async => Right(weeklyWorkoutDays));

    // act
    var result = await useCase();

    // assert
    expect(result, Right(dailyDrinkingGoal));
  });

  test('Should return CacheFailure when getWeight fails', () async {
    int weeklyWorkoutDays = 5;

    // arrange
    when(() => mockUserRepository.getWeight()).thenAnswer((_) async => Left(CacheFailure()));
    when(() => mockUserRepository.getWeeklyWorkoutDays()).thenAnswer((_) async => Right(weeklyWorkoutDays));

    // act
    var result = await useCase();
    var expectedResult = result.fold((failure) => failure, (_) {});

    // assert
    expect(expectedResult, isA<CacheFailure>());
  });

  test('Should return CacheFailure when getWeeklyWorkoutDays fails', () async {
    int weight = 75;

    // arrange
    when(() => mockUserRepository.getWeight()).thenAnswer((_) async => Right(weight));
    when(() => mockUserRepository.getWeeklyWorkoutDays()).thenAnswer((_) async => Left(CacheFailure()));

    // act
    var result = await useCase();
    var expectedResult = result.fold((failure) => failure, (_) {});

    // assert
    expect(expectedResult, isA<CacheFailure>());
  });
}
