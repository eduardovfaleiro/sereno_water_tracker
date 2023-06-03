import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/error/exceptions.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/amount_of_water_drank_today_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/amount_of_water_drank_today_repository.dart';

import 'amount_of_water_drank_today_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AmountOfWaterDrankTodayDataSource>()])
void main() {
  late MockAmountOfWaterDrankTodayDataSource mockAmountOfWaterDrankTodayDataSource;
  late AmountOfWaterDrankTodayRepository repository;

  setUp(() {
    mockAmountOfWaterDrankTodayDataSource = MockAmountOfWaterDrankTodayDataSource();
    repository = AmountOfWaterDrankTodayRepositoryImp(mockAmountOfWaterDrankTodayDataSource);
  });

  group('get', () {
    const amountOfWaterDrankToday = 1000;
    test('Should return the amount of water drank today if call to datasource is successful', () async {
      when(mockAmountOfWaterDrankTodayDataSource.get()).thenAnswer((_) async => amountOfWaterDrankToday);

      var result = await repository.get();

      verify(mockAmountOfWaterDrankTodayDataSource.get());

      expect(result, const Right(amountOfWaterDrankToday));
    });

    test('Should return CacheFailure if call to datasource fails', () async {
      when(mockAmountOfWaterDrankTodayDataSource.get()).thenThrow((_) => CacheException());

      var result = await repository.get();
      var expectedResult = result.fold((l) => l, (r) => null);

      verify(mockAmountOfWaterDrankTodayDataSource.get());

      expect(expectedResult, isA<CacheFailure>());
    });
  });

  group('addUp', () {
    const amountToAddUp = 500;
    const amountOfWaterDrankTodayUpdated = 1500;

    test(
        'Should return the amount of water drank today after adding up '
        'if call to datasource is successful', () async {
      when(mockAmountOfWaterDrankTodayDataSource.addUp(any)).thenAnswer((_) async => amountOfWaterDrankTodayUpdated);

      var result = await repository.addUp(amountToAddUp);

      verify(mockAmountOfWaterDrankTodayDataSource.addUp(amountToAddUp));

      expect(result, const Right(amountOfWaterDrankTodayUpdated));
    });

    test('Should return CacheFailure if call to datasource fails', () async {
      when(mockAmountOfWaterDrankTodayDataSource.addUp(any)).thenThrow((_) => CacheException());

      var result = await repository.addUp(amountToAddUp);
      var expectedResult = result.fold((l) => l, (r) => null);

      verify(mockAmountOfWaterDrankTodayDataSource.addUp(amountToAddUp));

      expect(expectedResult, isA<CacheFailure>());
    });
  });
}
