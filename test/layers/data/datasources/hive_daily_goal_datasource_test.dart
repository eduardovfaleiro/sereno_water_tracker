import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late DailyDrinkingGoalDataSource dataSource;
  late int amount;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveDailyDrinkingGoalDataSource(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
    amount = 1000;
  });

  group('get', () {
    test('Should return the amount of water drank today', () async {
      when(() => mockBox.get(any())).thenReturn(amount);

      var result = await dataSource.get();

      verifyInOrder([
        () => mockHiveInterface.box(WATER_DATA),
        () => mockBox.get(DAILY_DRINKING_GOAL),
      ]);

      expect(result, amount);
    });
  });
}
