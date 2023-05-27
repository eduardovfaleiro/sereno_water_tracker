import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../layers/data/datasources/local/water_container/hive_water_container_datasource_test.mocks.dart';
import 'my_hive_test.mocks.dart';

abstract class GetApplicationDocumentsDirectory {
  Future<Directory> call();
}

class MyHive {
  final HiveInterface _hiveInterface;

  const MyHive(this._hiveInterface);

  Future<void> initFlutter(Directory directory) async {
    await _hiveInterface.initFlutter(directory.path);
  }

  Future<void> openBoxes(List<String> boxesNamesToOpen) async {
    for (String boxName in boxesNamesToOpen) {
      await _hiveInterface.openBox(boxName);
    }
  }
}

@GenerateNiceMocks([MockSpec<GetApplicationDocumentsDirectory>()])
void main() {
  late MockGetApplicationDocumentsDirectory mockGetApplicationDocumentsDirectory;
  late MockHiveInterface mockHiveInterface;
  late MyHive myHive;

  setUp(() {
    mockGetApplicationDocumentsDirectory = MockGetApplicationDocumentsDirectory();
    mockHiveInterface = MockHiveInterface();
    myHive = MyHive(mockHiveInterface);
  });

  group('initFlutter', () {
    const directoryPath = "/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter";

    test('Should forward the call to HiveInterface', () async {
      when(mockGetApplicationDocumentsDirectory()).thenAnswer(
        (_) async => Directory(directoryPath),
      );

      await myHive.initFlutter(await mockGetApplicationDocumentsDirectory());

      verify(mockGetApplicationDocumentsDirectory());
    });
  });
}
