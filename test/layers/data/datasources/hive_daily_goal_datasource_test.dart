import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal/daily_goal_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal/hive_daily_goal_datasource_imp.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late DailyGoalDataSource dataSource;
  late int amount;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveDailyGoalDataSource(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
    amount = 1000;
  });

  group('get', () {
    test('Should return the amount of water drank today', () async {
      when(() => mockBox.get(any())).thenReturn(amount);

      var result = await dataSource.get();

      verifyInOrder([
        () => mockHiveInterface.box(WATER_DATA),
        () => mockBox.get(DAILY_GOAL),
      ]);

      expect(result, amount);
    });
  });

  group('create', () {
    test('Should make the call to HiveInterface', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await dataSource.create(amount);

      verifyInOrder([
        () => mockHiveInterface.box(WATER_DATA),
        () => mockBox.put(DAILY_GOAL, amount),
      ]);
    });
  });
}
