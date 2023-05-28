import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/utils/constants/constants.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/water_container/hive_water_container_datasource_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/water_container/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/dtos/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/entities/water_container_entity.dart';

import 'hive_water_container_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HiveInterface>(), MockSpec<Box>()])
void main() {
  late MockHiveInterface mockHiveInterface;
  late WaterContainerDataSource dataSource;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWaterContainerDataSourceImp(mockHiveInterface);
  });

  group('create', () {
    test("Should return the water container index if it's sucessfully added to the box", () async {
      var waterContainerEntity = WaterContainerEntity(200, 'cup');

      int number = 1;
      var mockBox = MockBox();

      when(mockHiveInterface.box(any)).thenReturn(mockBox);
      when(mockBox.add(any)).thenAnswer((_) async => number);

      int result = await dataSource.create(waterContainerEntity);

      verifyInOrder([
        mockHiveInterface.box(WATER_CONTAINER),
        mockBox.add(waterContainerEntity),
      ]);

      expect(result, number);
    });
  });

  group('delete', () {
    test('Should forward the call to HiveInterface', () async {
      int id = 1;
      var mockBox = MockBox();

      when(mockHiveInterface.box(any)).thenReturn(mockBox);

      await dataSource.delete(id);

      verify(mockHiveInterface.box(WATER_CONTAINER));
      verify(mockBox.delete(id));
    });
  });

  group('get', () {
    test('Should return a water container', () async {
      var waterContainerDto = WaterContainerDto(200, 'cup', 1);

      int id = 1;
      var mockBox = MockBox();

      when(mockHiveInterface.box(any)).thenReturn(mockBox);
      when(mockBox.getAt(id)).thenAnswer((_) async => waterContainerDto);

      var result = await dataSource.get(id);

      verify(mockHiveInterface.box(WATER_CONTAINER));
      verify(mockBox.getAt(id));

      expect(result, waterContainerDto);
    });
  });
}
