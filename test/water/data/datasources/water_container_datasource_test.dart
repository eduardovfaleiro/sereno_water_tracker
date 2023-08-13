import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/water_container_datasource.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';

import '../../../mocks.dart';

void main() {
  final mockBox = MockBox();
  final mockHiveInterface = MockHiveInterface();
  final dataSource = HiveWaterContainerDataSource(mockHiveInterface);

  group('getAll', () {
    test('Should return list of water containersl', () async {
      final waterContainers = [
        const WaterContainerEntity(assetName: 'assetName', amount: 100),
        const WaterContainerEntity(assetName: 'assetName', amount: 200),
      ];

      when(() => mockHiveInterface.box(WATER_CONTAINER)).thenReturn(mockBox);
      when(() => mockBox.values).thenReturn(waterContainers);

      final result = await dataSource.getAll();

      verify(() => mockHiveInterface.box(WATER_CONTAINER));
      verify(() => mockBox.values);

      expect(result, waterContainers);
    });
  });
}