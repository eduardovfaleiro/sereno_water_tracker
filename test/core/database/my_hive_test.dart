import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';

import '../../layers/data/datasources/hive_amount_of_water_drank_today_test.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

void main() {
  late MockHiveInterface mockHiveInterface;
  late MyHive myHive;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    myHive = MyHive(mockHiveInterface);
  });

  group('init', () {
    const directoryPath = "/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter";

    test('Should forward the call to HiveInterface', () {
      myHive.init(directoryPath);

      verify(() => mockHiveInterface.init(directoryPath));
    });
  });

  group('openBoxes', () {
    const boxesNamesToOpen = <String>['test1', 'test2'];

    test('Should forward the call to open every box on the passed list', () async {
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => MockBox());
      await myHive.openBoxes(boxesNamesToOpen);

      for (var boxName in boxesNamesToOpen) {
        verify(() => mockHiveInterface.openBox(boxName));
      }
    });
  });
}
