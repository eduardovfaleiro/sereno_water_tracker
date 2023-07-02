import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weight_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late WeightDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWeightDataSourceImp(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
  });

  group('get', () {
    double weight = 75;

    test('Should make call for hive to return the user\'s weight', () async {
      // arrange
      when(() => mockBox.get(any())).thenAnswer((_) => weight);

      // act
      var result = await dataSource.get();

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.get(WEIGHT),
      ]);

      expect(result, weight);
    });
  });

  group('update', () {
    double weight = 75;

    test('Should make call for hive to update the user\'s weight', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // act
      await dataSource.update(weight);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WEIGHT, weight),
      ]);
    });
  });
}
