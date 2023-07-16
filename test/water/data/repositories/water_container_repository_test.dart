import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/icon_name.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/data/repositories/water_container_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/repositories/water_container_repository.dart';

class MockWaterContainerDataSource extends Mock implements WaterContainerDataSource {}

void main() {
  late MockWaterContainerDataSource mockWaterContainerDataSource;
  late WaterContainerRepository repository;

  setUp(() {
    mockWaterContainerDataSource = MockWaterContainerDataSource();
    repository = WaterContainerRepositoryImp(mockWaterContainerDataSource);
  });

  setUpAll(() {
    registerFallbackValue(WaterContainerEntity(amount: 200, description: 'cup', iconName: IconName.cup));
  });

  group('get', () {
    int id = 1;
    var waterContainerDto = WaterContainerDto(id: 0, amount: 200, description: 'cup', iconName: IconName.cup);

    test('Should return a water container when call to datasource is sucessful', () async {
      when(() => mockWaterContainerDataSource.get(any())).thenAnswer((_) async => waterContainerDto);

      var result = await repository.get(id);

      verify(() => mockWaterContainerDataSource.get(id));

      expect(result, Right(waterContainerDto));
    });

    // test('Should return a CacheFailure when call to datasource fails', () async {
    //   when(() => mockWaterContainerDataSource.get(any())).thenThrow(CacheException());

    //   var result = await repository.get(id);
    //   var expectedResult = result.fold((l) => l, (r) => null);

    //   verify(() => mockWaterContainerDataSource.get(id));

    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });

  group('getAllContainers', () {
    var allWaterContainers = <WaterContainerDto>[
      WaterContainerDto(id: 0, amount: 100, description: 'tea cup', iconName: IconName.cup),
      WaterContainerDto(id: 1, amount: 200, description: 'normal cup', iconName: IconName.cup),
      WaterContainerDto(id: 2, amount: 500, description: 'bottle', iconName: IconName.cup),
    ];

    test('Should return all water containers if call to datasource is succesful', () async {
      when(() => mockWaterContainerDataSource.getAllContainers()).thenAnswer((_) async => allWaterContainers);

      var result = await repository.getAllContainers();

      verify(() => mockWaterContainerDataSource.getAllContainers());
      expect(result, Right(allWaterContainers));
    });

    // test('Should return CacheFailure if call to datasource fails', () async {
    //   when(() => mockWaterContainerDataSource.getAllContainers()).thenThrow((_) => CacheException());

    //   var result = await repository.getAllContainers();
    //   var expectedResult = result.fold((l) => l, (r) => null);

    //   verify(() => mockWaterContainerDataSource.getAllContainers());
    //   expect(expectedResult, isA<CacheFailure>());
    // });
  });

  group('create', () {
    int id = 1;
    var waterContainerEntity = WaterContainerEntity(amount: 200, description: 'cup', iconName: IconName.cup);

    test('Should return an int when call to datasource is successful', () async {
      when(() => mockWaterContainerDataSource.create(any())).thenAnswer((_) async => id);

      await repository.create(waterContainerEntity);

      verify(() => mockWaterContainerDataSource.create(waterContainerEntity));
    });
  });

  // group('delete', () {
  //   int id = 1;

  // test('Should return a CacheFailure when call to datasource fails', () async {
  //   when(() => mockWaterContainerDataSource.delete(any())).thenThrow(CacheException());

  //   var result = await repository.delete(id);
  //   var expectedResult = result.fold((l) => l, (r) => null);

  //   verify(() => mockWaterContainerDataSource.delete(id));

  //   expect(expectedResult, isA<CacheFailure>());
  // });
  // });
}
