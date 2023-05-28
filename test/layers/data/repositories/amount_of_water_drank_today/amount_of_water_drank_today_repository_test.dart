import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/error/exceptions.dart';
import 'package:sereno_clean_architecture_solid/core/error/failures.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/amount_of_water_drank_today_repository.dart';

import 'amount_of_water_drank_today_repository_test.mocks.dart';

class AmountOfWaterDrankTodayRepositoryImp implements AmountOfWaterDrankTodayRepository {
  final AmountOfWaterDrankTodayDataSource _amountOfWaterDrankTodayDataSource;

  AmountOfWaterDrankTodayRepositoryImp(this._amountOfWaterDrankTodayDataSource);

  @override
  Future<Either<Failure, int>> get() async {
    try {
      return Right(await _amountOfWaterDrankTodayDataSource.get());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> put(int amount) {
    throw UnimplementedError();
  }
}

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
}
