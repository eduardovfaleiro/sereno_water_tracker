import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/water_container_repository.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';

class MockWaterContainerDataSource extends Mock implements WaterContainerDataSource {}

void main() {
  final mockWaterContainerDataSource = MockWaterContainerDataSource();
  final repository = WaterContainerRepositoryImp(mockWaterContainerDataSource);

  test('Should return list of water containers when call to datasource is successful', () async {
    final waterContainers = [
      const WaterContainerEntity(assetName: 'assetName', amount: 100),
      const WaterContainerEntity(assetName: 'assetName', amount: 200),
    ];

    when(() => mockWaterContainerDataSource.getAll()).thenAnswer((invocation) async => waterContainers);

    final result = await repository.getAll();

    verify(() => mockWaterContainerDataSource.getAll());
    expect(result, Right(waterContainers));
  });
}
