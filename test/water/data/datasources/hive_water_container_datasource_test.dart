import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late WaterContainerDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWaterContainerDataSourceImp(mockHiveInterface);
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
        waterContainerIcon: WaterContainerIcon.cup,
      );

      var waterContainerDto = WaterContainerDto.fromEntity(waterContainerEntity);

      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.add(any())).thenAnswer((_) async => 0);

      await dataSource.create(waterContainerEntity);

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
    var allWaterContainers = <WaterContainerDto>[
      WaterContainerDto(amount: 100, waterContainerIcon: WaterContainerIcon.cup),
      WaterContainerDto(amount: 200, waterContainerIcon: WaterContainerIcon.cup),
      WaterContainerDto(amount: 500, waterContainerIcon: WaterContainerIcon.cup),
    ];

    test('Should return all water containers when call to datasource is successful', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.values).thenReturn(allWaterContainers);

      var result = await dataSource.getAllContainers();

      verifyInOrder([() => mockHiveInterface.box(WATER_CONTAINER), () => mockBox.values]);

      List<WaterContainerEntity> allWaterContainersEntities = allWaterContainers.map((e) => e.toEntity()).toList();

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
