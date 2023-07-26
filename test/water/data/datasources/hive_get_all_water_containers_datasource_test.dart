import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/get_all_water_containers_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';

import '../../../mocks.dart';

class MockConvertWaterContainerDtoToEntityUseCase extends Mock implements ConvertWaterContainerDtoToEntityUseCase {}

void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;

  late MockConvertWaterContainerDtoToEntityUseCase mockConvertWaterContainerDtoToEntityUseCase;

  late GetAllWaterContainersDataSource dataSource;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    mockConvertWaterContainerDtoToEntityUseCase = MockConvertWaterContainerDtoToEntityUseCase();

    dataSource = HiveGetAllWaterContainersDataSourceImp(
      mockHiveInterface,
      mockConvertWaterContainerDtoToEntityUseCase,
    );

    registerFallbackValue(const WaterContainerEntity(icon: TEST_ICON, amount: 0));
    registerFallbackValue(WaterContainerDto(waterContainerIcon: TEST_WATER_CONTAINER_ICON, amount: 0));
  });

  test('Should return list of water containers', () async {
    List<WaterContainerEntity> entities = [
      const WaterContainerEntity(icon: TEST_ICON, amount: 200),
      const WaterContainerEntity(icon: TEST_ICON, amount: 500),
      const WaterContainerEntity(icon: TEST_ICON, amount: 1000),
    ];

    List<WaterContainerDto> dtos = [
      WaterContainerDto(waterContainerIcon: TEST_WATER_CONTAINER_ICON, amount: 200),
      WaterContainerDto(waterContainerIcon: TEST_WATER_CONTAINER_ICON, amount: 500),
      WaterContainerDto(waterContainerIcon: TEST_WATER_CONTAINER_ICON, amount: 1000),
    ];

    // arrange
    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
    when(() => mockBox.values).thenReturn(dtos);

    for (int i = 0; i < entities.length; i++) {
      when(() => mockConvertWaterContainerDtoToEntityUseCase(dtos[i])).thenReturn(entities[i]);
    }

    // act
    var result = await dataSource();

    // assert
    verify(() => mockConvertWaterContainerDtoToEntityUseCase(any()));

    verifyInOrder([
      () => mockHiveInterface.box(WATER_CONTAINER),
      () => mockBox.values,
    ]);

    expect(result, entities);
  });
}
