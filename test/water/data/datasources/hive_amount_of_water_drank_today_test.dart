import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/water/data/datasources/amount_of_water_drank_today_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late AmountOfWaterDrankTodayDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveAmountOfWaterDrankTodayDataSourceImp(mockHiveInterface);
  });

  group('addUp', () {
    const amountOfWaterDrankToday = 1000;
    const amountToAddUp = 500;

    const amountOfWaterDrankTodayAddedUp = 1500;

    test('Should return the amount of water drank today after adding up', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);

      when(() => mockBox.get(any())).thenReturn(amountOfWaterDrankToday);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => amountOfWaterDrankTodayAddedUp);

      await dataSource.addUp(amountToAddUp);

      verifyInOrder([
        () => mockHiveInterface.box(WATER_DATA),
        () => mockBox.get(AMOUNT_OF_WATER_DRANK_TODAY),
        () => mockBox.put(AMOUNT_OF_WATER_DRANK_TODAY, amountOfWaterDrankTodayAddedUp),
      ]);
    });
  });

  group('get', () {
    const amountOfWaterDrankToday = 1000;

    test('Should return the amount of water drank today', () async {
      when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
      when(() => mockBox.get(any(), defaultValue: any(named: 'defaultValue'))).thenAnswer((_) async => amountOfWaterDrankToday);

      var result = await dataSource.get();

      verifyInOrder([
        () => mockHiveInterface.box(WATER_DATA),
        () => mockBox.get(AMOUNT_OF_WATER_DRANK_TODAY, defaultValue: 0),
      ]);

      expect(result, amountOfWaterDrankToday);
    });
  });
}
