import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_drinking_frequency_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/daily_drinking_frequency_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_drinking_frequency_repository.dart';

class MockDailyDrinkingFrequencyDataSource extends Mock implements DailyDrinkingFrequencyDataSource {}

void main() {
  late MockDailyDrinkingFrequencyDataSource mockDailyDrinkingFrequencyDataSource;
  late DailyDrinkingFrequencyRepository repository;

  setUp(() {
    mockDailyDrinkingFrequencyDataSource = MockDailyDrinkingFrequencyDataSource();
    repository = DailyDrinkingFrequencyRepositoryImp(mockDailyDrinkingFrequencyDataSource);
  });

  group('get', () {
    int dailyDrinkingFrequency = 5;

    test(
        'Should return how many times the user should drink '
        'a day if call to datasource if successful', () async {
      // arrange
      when(() => mockDailyDrinkingFrequencyDataSource.get()).thenAnswer((_) async => dailyDrinkingFrequency);

      // act
      var result = await repository.get();

      // assert
      verify(() => mockDailyDrinkingFrequencyDataSource.get());
      expect(result, Right(dailyDrinkingFrequency));
    });
  });
}
