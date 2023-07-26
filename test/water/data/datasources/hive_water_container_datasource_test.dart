import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/get_all_water_containers_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_entity_to_dto_usecase.dart';

import '../../../mocks.dart';

class MockConvertWaterContainerEntityToDtoUseCase extends Mock implements ConvertWaterContainerEntityToDtoUseCase {}

class MockConvertWaterContainerDtoToEntityUseCase extends Mock implements ConvertWaterContainerDtoToEntityUseCase {}

class MockGetAllWaterContainersDataSource extends Mock implements GetAllWaterContainersDataSource {}

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late WaterContainerDataSource dataSource;
  late MockConvertWaterContainerEntityToDtoUseCase mockConvertWaterContainerEntityToDtoUseCase;
  late MockConvertWaterContainerDtoToEntityUseCase mockConvertWaterContainerDtoToEntityUseCase;
  late MockGetAllWaterContainersDataSource mockGetAllWaterContainersDataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    mockConvertWaterContainerEntityToDtoUseCase = MockConvertWaterContainerEntityToDtoUseCase();
    mockConvertWaterContainerDtoToEntityUseCase = MockConvertWaterContainerDtoToEntityUseCase();
    mockGetAllWaterContainersDataSource = MockGetAllWaterContainersDataSource();

    dataSource = HiveWaterContainerDataSourceImp(
      mockHiveInterface,
      mockConvertWaterContainerEntityToDtoUseCase,
      mockConvertWaterContainerDtoToEntityUseCase,
      mockGetAllWaterContainersDataSource,
    );

    registerFallbackValue(const WaterContainerEntity(icon: CommunityMaterialIcons.cup_water, amount: 0));
    registerFallbackValue(WaterContainerDto(waterContainerIcon: WaterContainerIcon.cup, amount: 0));
  });

  group('create', () {
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
    List<WaterContainerEntity> waterContainerEntities = [
      const WaterContainerEntity(icon: TEST_ICON, amount: 200),
      const WaterContainerEntity(icon: TEST_ICON, amount: 500),
      const WaterContainerEntity(icon: TEST_ICON, amount: 1000),
    ];

    int index = 1;

    WaterContainerEntity waterContainerEntity = waterContainerEntities[index];

    test('Should forward the call to HiveInterface', () async {
      when(() => mockGetAllWaterContainersDataSource()).thenAnswer((_) async => waterContainerEntities);
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      await dataSource.delete(waterContainerEntity);

      verify(() => mockHiveInterface.box(WATER_CONTAINER));
      verify(() => mockBox.delete(index));
    });
  });

  group('getAllContainers', () {
    var waterContainerDtos = <WaterContainerDto>[
      WaterContainerDto(amount: 100, waterContainerIcon: TEST_WATER_CONTAINER_ICON),
      WaterContainerDto(amount: 200, waterContainerIcon: TEST_WATER_CONTAINER_ICON),
      WaterContainerDto(amount: 500, waterContainerIcon: TEST_WATER_CONTAINER_ICON),
    ];

    var waterContainerEntities = <WaterContainerEntity>[
      const WaterContainerEntity(amount: 100, icon: TEST_ICON),
      const WaterContainerEntity(amount: 200, icon: TEST_ICON),
      const WaterContainerEntity(amount: 500, icon: TEST_ICON),
    ];

    test('Should return all water containers when call to datasource is successful', () async {
      when(() => mockGetAllWaterContainersDataSource()).thenAnswer((_) async => waterContainerEntities);

      for (int i = 0; i < waterContainerEntities.length; i++) {
        when(() => mockConvertWaterContainerDtoToEntityUseCase(waterContainerDtos[i])).thenReturn(waterContainerEntities[i]);
      }

      var result = await dataSource.getAllContainers();

      verify(() => mockGetAllWaterContainersDataSource());

      expect(result, waterContainerEntities);
    });
  });
}
