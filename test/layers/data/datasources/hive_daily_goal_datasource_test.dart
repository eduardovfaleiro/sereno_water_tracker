import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/daily_goal/daily_goal_datasource.dart';

import '../../../core/database/my_hive_test.dart';
import 'hive_amount_of_water_drank_today_test.dart';

class HiveDailyGoalDataSource implements DailyGoalDataSource {
  final HiveInterface _hiveInterface;

  HiveDailyGoalDataSource(this._hiveInterface);

  @override
  Future<void> create(int amount) async {
    _hiveInterface.box(WATER_DATA).put(DAILY_GOAL, amount);
  }

  @override
  Future<int> get() async {
    return _hiveInterface.box(WATER_DATA).get(DAILY_GOAL);
  }

  @override
  Future<int> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}

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
