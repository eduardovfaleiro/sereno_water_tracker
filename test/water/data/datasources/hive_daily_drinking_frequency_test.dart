import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/daily_drinking_frequency_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late HiveNumberOfTimesToDrinkWaterDailyDataSourceImp dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveNumberOfTimesToDrinkWaterDailyDataSourceImp(mockHiveInterface);
  });

  group('get', () {
    int numberOfTimesToDrinkWaterDaily = 5;

    test('Should return how many times the user should drink a day', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.get(DAILY_DRINKING_FREQUENCY)).thenAnswer((_) => numberOfTimesToDrinkWaterDaily);

      // act
      var result = await dataSource.get();

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.get(DAILY_DRINKING_FREQUENCY),
      ]);

      expect(result, numberOfTimesToDrinkWaterDaily);
    });
  });
}
