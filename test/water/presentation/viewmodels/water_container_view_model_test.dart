import 'package:community_material_icon/community_material_icon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
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
      const WaterContainerEntity(
        icon: CommunityMaterialIcons.cup,
        amount: 0,
      ),
    );

    registerFallbackValue(
      WaterContainerDto(
        waterContainerIcon: WaterContainerIcon.cup,
        amount: 0,
      ),
    );
  });

  group('getAllContainers', () {
    var containers = <WaterContainerEntity>[
      const WaterContainerEntity(amount: 200, icon: CommunityMaterialIcons.cup),
      const WaterContainerEntity(amount: 500, icon: CommunityMaterialIcons.cup),
      const WaterContainerEntity(amount: 600, icon: CommunityMaterialIcons.cup),
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
    var waterContainerEntity = const WaterContainerEntity(
      icon: CommunityMaterialIcons.cup,
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
    var waterContainerEntity = const WaterContainerEntity(
      icon: CommunityMaterialIcons.cup,
      amount: 0,
    );

    test('Should update waterContainer according to the id', () async {
      // arrange
      when(() => mockWaterContainerRepository.update(any())).thenAnswer((_) async => const Right(null));

      // act
      var result = await viewModel.update(waterContainerEntity);

      // assert
      verify(() => mockWaterContainerRepository.update(waterContainerEntity));

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
