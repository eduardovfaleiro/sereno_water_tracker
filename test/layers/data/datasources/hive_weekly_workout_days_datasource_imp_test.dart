import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weekly_workout_days_datasource.dart';

import '../../../mocks.dart';

void main() {
  late MockBox mockBox;
  late MockHiveInterface mockHiveInterface;
  late WeeklyWorkoutDaysDataSource dataSource;

  setUp(() {
    mockBox = MockBox();
    mockHiveInterface = MockHiveInterface();
    dataSource = HiveWeeklyWorkoutDaysDataSourceImp(mockHiveInterface);

    when(() => mockHiveInterface.box(any())).thenReturn(mockBox);
  });

  group('get', () {
    int weeklyWorkoutDays = 5;

    test('Should return the user\'s weekly workout days', () async {
      // arrange
      when(() => mockBox.get(any())).thenAnswer((_) async => weeklyWorkoutDays);

      // act
      var result = await dataSource.get();

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.get(WEEKLY_WORKOUT_DAYS),
      ]);

      expect(result, weeklyWorkoutDays);
    });
  });

  group('update', () {
    int weeklyWorkoutDays = 5;

    test('Should update the user\'s weekly workout days', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenAnswer((invocation) async {});

      // act
      await dataSource.update(weeklyWorkoutDays);

      // assert
      verifyInOrder([
        () => mockHiveInterface.box(USER_DATA),
        () => mockBox.put(WEEKLY_WORKOUT_DAYS, weeklyWorkoutDays),
      ]);
    });
  });
}
