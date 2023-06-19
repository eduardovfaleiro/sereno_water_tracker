import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/times_to_drink_per_day_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/daily_drinking_frequency_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_drinking_frequency_repository.dart';

class MockTimesToDrinkPerDayDataSource extends Mock implements TimesToDrinkPerDayDataSource {}

void main() {
  late MockTimesToDrinkPerDayDataSource mockTimesToDrinkPerDayDataSource;
  late TimesToDrinkPerDayRepository repository;

  setUp(() {
    mockTimesToDrinkPerDayDataSource = MockTimesToDrinkPerDayDataSource();
    repository = TimesToDrinkPerDayRepositoryImp(mockTimesToDrinkPerDayDataSource);
  });

  group('get', () {
    int timesToDrinkPerDay = 5;

    test(
        'Should return how many times the user should drink '
        'a day if call to datasource if successful', () async {
      // arrange
      when(() => mockTimesToDrinkPerDayDataSource.get()).thenAnswer((_) async => timesToDrinkPerDay);

      // act
      var result = await repository.get();

      // assert
      verify(() => mockTimesToDrinkPerDayDataSource.get());
      expect(result, Right(timesToDrinkPerDay));
    });
  });
}
