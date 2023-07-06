import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_drinking_frequency_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/daily_drinking_frequency_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/daily_drinking_frequency_repository.dart';

class MockNumberOfTimesToDrinkWaterDailyDataSource extends Mock implements NumberOfTimesToDrinkWaterDailyDataSource {}

void main() {
  late MockNumberOfTimesToDrinkWaterDailyDataSource mockNumberOfTimesToDrinkWaterDailyDataSource;
  late NumberOfTimesToDrinkWaterDailyRepository repository;

  setUp(() {
    mockNumberOfTimesToDrinkWaterDailyDataSource = MockNumberOfTimesToDrinkWaterDailyDataSource();
    repository = NumberOfTimesToDrinkWaterDailyRepositoryImp(mockNumberOfTimesToDrinkWaterDailyDataSource);
  });

  group('get', () {
    int numberOfTimesToDrinkWaterDaily = 5;

    test(
        'Should return how many times the user should drink '
        'a day if call to datasource if successful', () async {
      // arrange
      when(() => mockNumberOfTimesToDrinkWaterDailyDataSource.get()).thenAnswer((_) async => numberOfTimesToDrinkWaterDaily);

      // act
      var result = await repository.get();

      // assert
      verify(() => mockNumberOfTimesToDrinkWaterDailyDataSource.get());
      expect(result, Right(numberOfTimesToDrinkWaterDaily));
    });
  });
}
