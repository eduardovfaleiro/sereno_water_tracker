import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/core/database/my_hive.dart';

import '../../layers/data/datasources/amount_of_water_drank_today/hive_amount_of_water_drank_today_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HiveInterface>()])
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

      verify(mockHiveInterface.init(directoryPath));
    });
  });

  group('openBoxes', () {
    const boxesNamesToOpen = <String>['test1', 'test2'];

    test('Should forward the call to open every box on the passed list', () async {
      await myHive.openBoxes(boxesNamesToOpen);

      for (var boxName in boxesNamesToOpen) {
        verify(mockHiveInterface.openBox(boxName));
      }
    });
  });
}
