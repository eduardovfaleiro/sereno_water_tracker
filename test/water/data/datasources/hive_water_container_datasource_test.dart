import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_entity_to_dto_usecase.dart';

import '../../../mocks.dart';

class MockConvertWaterContainerEntityToDtoUseCase extends Mock implements ConvertWaterContainerEntityToDtoUseCase {}

class MockConvertWaterContainerDtoToEntityUseCase extends Mock implements ConvertWaterContainerDtoToEntityUseCase {}

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late WaterContainerDataSource dataSource;
  late MockConvertWaterContainerEntityToDtoUseCase mockConvertWaterContainerEntityToDtoUseCase;
  late MockConvertWaterContainerDtoToEntityUseCase mockConvertWaterContainerDtoToEntityUseCase;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    mockConvertWaterContainerEntityToDtoUseCase = MockConvertWaterContainerEntityToDtoUseCase();
    mockConvertWaterContainerDtoToEntityUseCase = MockConvertWaterContainerDtoToEntityUseCase();
    dataSource = HiveWaterContainerDataSourceImp(
      mockHiveInterface,
      mockConvertWaterContainerEntityToDtoUseCase,
      mockConvertWaterContainerDtoToEntityUseCase,
    );

    registerFallbackValue(const WaterContainerEntity(icon: CommunityMaterialIcons.cup_water, amount: 0));
    registerFallbackValue(WaterContainerDto(waterContainerIcon: WaterContainerIcon.cup, amount: 0));
  });

  group('create', () {
    /*
      Future<int> create(WaterContainerEntity waterContainerEntity) {
    var waterContainerDto = WaterContainerDto(
      description: waterContainerEntity.description,
      WaterContainerIcon: waterContainerEntity.WaterContainerIcon,
      amount: waterContainerEntity.amount,
    );

    return _hiveInterface.box(WATER_CONTAINER).add(waterContainerDto);
  }

    */

    test("Should return the water container index when it's sucessfully added to the box", () async {
      var waterContainerEntity = const WaterContainerEntity(
        amount: 200,
        icon: CommunityMaterialIcons.cup,
      );

      var waterContainerDto = WaterContainerDto(amount: 200, waterContainerIcon: WaterContainerIcon.cup);

      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.add(any())).thenAnswer((_) async => 0);
      when(() => mockConvertWaterContainerEntityToDtoUseCase(any())).thenReturn(waterContainerDto);

      await dataSource.create(waterContainerEntity);

      verify(() => mockConvertWaterContainerEntityToDtoUseCase(waterContainerEntity));

      verifyInOrder([
        () => mockHiveInterface.box(WATER_CONTAINER),
        () => mockBox.add(waterContainerDto),
      ]);
    });
  });

  group('delete', () {
    test('Should forward the call to HiveInterface', () async {
      int id = 1;

      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      await dataSource.delete(id);

      verify(() => mockHiveInterface.box(WATER_CONTAINER));
      verify(() => mockBox.delete(id));
    });
  });

  group('getAllContainers', () {
    var allWaterContainersDtos = <WaterContainerDto>[
      WaterContainerDto(amount: 100, waterContainerIcon: WaterContainerIcon.cup),
      WaterContainerDto(amount: 200, waterContainerIcon: WaterContainerIcon.cup),
      WaterContainerDto(amount: 500, waterContainerIcon: WaterContainerIcon.cup),
    ];

    var allWaterContainersEntities = <WaterContainerEntity>[
      const WaterContainerEntity(amount: 100, icon: CommunityMaterialIcons.cup_water),
      const WaterContainerEntity(amount: 200, icon: CommunityMaterialIcons.cup_water),
      const WaterContainerEntity(amount: 500, icon: CommunityMaterialIcons.cup_water),
    ];

    test('Should return all water containers when call to datasource is successful', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.values).thenReturn(allWaterContainersDtos);

      for (int i = 0; i < allWaterContainersEntities.length; i++) {
        when(() => mockConvertWaterContainerDtoToEntityUseCase(allWaterContainersDtos[i])).thenReturn(allWaterContainersEntities[i]);
      }

      var result = await dataSource.getAllContainers();

      verify(() => mockConvertWaterContainerDtoToEntityUseCase(any()));

      verifyInOrder([
        () => mockHiveInterface.box(WATER_CONTAINER),
        () => mockBox.values,
      ]);

      expect(result, allWaterContainersEntities);
    });
  });

  group('get', () {
    test('Should return a water container', () async {
      var waterContainerDto = WaterContainerDto(amount: 200, waterContainerIcon: WaterContainerIcon.cup);

      int id = 1;
      var mockBox = MockBox();

      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.getAt(id)).thenAnswer((_) async => waterContainerDto);

      var result = await dataSource.get(id);

      verify(() => mockHiveInterface.box(WATER_CONTAINER));
      verify(() => mockBox.getAt(id));

      expect(result, waterContainerDto);
    });
  });
}
