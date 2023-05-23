import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/error/exceptions.dart';
import 'package:sereno_clean_architecture_solid/core/error/failures.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/local/water_container/water_container_local_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/dtos/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/water_container_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/water_container_repository.dart';

import 'water_container_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WaterContainerLocalDataSource>()])
void main() {
  late MockWaterContainerLocalDataSource mockWaterContainerLocalDataSource;
  late WaterContainerRepository repository;

  setUp(() {
    mockWaterContainerLocalDataSource = MockWaterContainerLocalDataSource();
    repository = WaterContainerRepositoryImp(mockWaterContainerLocalDataSource);
  });

  group('get', () {
    int id = 1;
    var waterContainerDto = WaterContainerDto(200, 'cup', id);

    test('Should return a water container when call to local datasource is sucessful', () async {
      when(mockWaterContainerLocalDataSource.get(any)).thenAnswer((_) async => waterContainerDto);

      var result = await repository.get(id);

      verify(mockWaterContainerLocalDataSource.get(id));

      expect(result, Right(waterContainerDto));
    });

    test('Should return a CacheFailure when call to local datasource fails', () async {
      when(mockWaterContainerLocalDataSource.get(any)).thenThrow(CacheException());

      var result = await repository.get(id);
      var expectedResult = result.fold((l) => l, (r) => null);

      verify(mockWaterContainerLocalDataSource.get(id));

      expect(expectedResult, isA<CacheFailure>());
    });
  });
}
