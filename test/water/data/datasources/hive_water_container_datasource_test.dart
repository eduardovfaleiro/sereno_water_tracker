import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/icon_name.dart';
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
    test("Should return the water container index if it's sucessfully added to the box", () async {
      var waterContainerEntity = WaterContainerEntity(amount: 200, description: 'cup', iconName: IconName.cup);

      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.add(any())).thenAnswer((_) async => 0);

      await dataSource.create(waterContainerEntity);

      verifyInOrder([
        () => mockHiveInterface.box(WATER_CONTAINER),
        () => mockBox.add(waterContainerEntity),
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
      WaterContainerDto(id: 0, amount: 100, description: 'tea cup', iconName: IconName.cup),
      WaterContainerDto(id: 1, amount: 200, description: 'normal cup', iconName: IconName.cup),
      WaterContainerDto(id: 2, amount: 500, description: 'bottle', iconName: IconName.cup),
    ];

    test('Should return all water containers if call to datasource is succesful', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.values).thenReturn(allWaterContainers);

      var result = await dataSource.getAllContainers();

      verifyInOrder([() => mockHiveInterface.box(WATER_CONTAINER), () => mockBox.values]);

      expect(result, allWaterContainers);
    });
  });

  group('get', () {
    test('Should return a water container', () async {
      var waterContainerDto = WaterContainerDto(id: 0, amount: 200, description: 'cup', iconName: IconName.cup);

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
