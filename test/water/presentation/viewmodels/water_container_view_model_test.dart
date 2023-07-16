import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/icon_name.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/repositories/water_container_repository.dart';
import 'package:sereno_clean_architecture_solid/water/presentation/view_models/water_container_view_model.dart';

class MockWaterContainerRepository extends Mock implements WaterContainerRepository {}

void main() {
  var mockWaterContainerRepository = MockWaterContainerRepository();
  var viewModel = WaterContainerViewModelImp(mockWaterContainerRepository);

  setUpAll(() {
    registerFallbackValue(
      WaterContainerEntity(
        description: 'test',
        iconName: IconName.cup,
        amount: 0,
      ),
    );

    registerFallbackValue(
      WaterContainerDto(
        id: 0,
        description: 'test',
        iconName: IconName.cup,
        amount: 0,
      ),
    );
  });

  group('getAllContainers', () {
    var containers = <WaterContainerEntity>[
      WaterContainerEntity(amount: 200, description: 'cup', iconName: IconName.cup),
      WaterContainerEntity(amount: 500, description: 'bottle', iconName: IconName.cup),
      WaterContainerEntity(amount: 600, description: 'bigger bottle', iconName: IconName.cup),
    ];

    test('Should return all water containers', () async {
      // arrange
      when(() => mockWaterContainerRepository.getAllContainers()).thenAnswer((_) async {
        return Right(containers);
      });

      // act
      var result = await viewModel.getAllContainers();

      // assert
      verify(() => mockWaterContainerRepository.getAllContainers());

      expect(result, Right(containers));
    });
  });

  group('create', () {
    var waterContainerEntity = WaterContainerEntity(
      description: 'test',
      iconName: IconName.cup,
      amount: 0,
    );

    test('Should create a water container', () async {
      // arrange
      when(() => mockWaterContainerRepository.create(any())).thenAnswer((_) async {
        return const Right(null);
      });

      // act
      var result = await viewModel.create(waterContainerEntity);

      // assert
      verify(() => mockWaterContainerRepository.create(waterContainerEntity));
      expect(result, const Right(null));
    });
  });

  group('update', () {
    var waterContainerDto = WaterContainerDto(
      id: 0,
      description: 'test',
      iconName: IconName.cup,
      amount: 0,
    );

    test('Should update waterContainer according to the id', () async {
      // arrange
      when(() => mockWaterContainerRepository.update(any())).thenAnswer((_) async => const Right(null));

      // act
      var result = await viewModel.update(waterContainerDto);

      // assert
      verify(() => mockWaterContainerRepository.update(waterContainerDto));

      expect(result, const Right(null));
    });
  });

  group('delete', () {
    int id = 0;

    test('Should delete waterContainer according to the id', () async {
      // arrange
      when(() => mockWaterContainerRepository.delete(any())).thenAnswer((_) async => const Right(null));

      // act
      var result = await viewModel.delete(id);

      // assert
      verify(() => mockWaterContainerRepository.delete(id));

      expect(result, const Right(null));
    });
  });
}
