import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weight_datasource.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late HiveWeightDataSourceImp dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWeightDataSourceImp(mockHiveInterface);
  });

  group('update', () {
    var weight = 75.0;

    test('Should call hiveInterface to update weight', () async {
      // arrange
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
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
