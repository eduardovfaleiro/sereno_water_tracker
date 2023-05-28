import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/utils/constants/constants.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/amount_of_water_drank_today/amount_of_water_drank_today_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/amount_of_water_drank_today/hive_amount_of_water_drank_today_datasource.dart';

import 'hive_amount_of_water_drank_today_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HiveInterface>(), MockSpec<Box>()])
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
      when(mockHiveInterface.box(any)).thenReturn(mockBox);

      when(mockBox.get(any)).thenReturn(amountOfWaterDrankToday);
      when(mockBox.put(any, any)).thenAnswer((_) async => amountOfWaterDrankTodayAddedUp);

      var result = await dataSource.addUp(amountToAddUp);

      verifyInOrder([
        mockHiveInterface.box(WATER_DATA),
        mockBox.get(AMOUNT_OF_WATER_DRANK_TODAY),
        mockBox.put(AMOUNT_OF_WATER_DRANK_TODAY, amountOfWaterDrankTodayAddedUp),
      ]);

      expect(result, amountOfWaterDrankTodayAddedUp);
    });
  });

  group('get', () {
    const amountOfWaterDrankToday = 1000;

    test('Should return the amount of water drank today', () async {
      when(mockHiveInterface.box(any)).thenReturn(mockBox);
      when(mockBox.get(any)).thenAnswer((_) async => amountOfWaterDrankToday);

      var result = await dataSource.get();

      verifyInOrder([
        mockHiveInterface.box(WATER_DATA),
        mockBox.get(AMOUNT_OF_WATER_DRANK_TODAY),
      ]);

      expect(result, amountOfWaterDrankToday);
    });
  });
}
