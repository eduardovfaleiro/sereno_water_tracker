import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:path_provider/path_provider.dart';

import 'init_hive_usecase_test.mocks.dart';

abstract class GetApplicationDocumentsDirectory {
  Future<Directory> call() => getApplicationDocumentsDirectory();
}

@GenerateNiceMocks([
  MockSpec<HiveInterface>(),
  MockSpec<Box>(),
  MockSpec<GetApplicationDocumentsDirectory>(),
])
void main() {
  var hiveMock = MockHiveInterface();
  var getApplicationDocumentsDirectoryMock = MockGetApplicationDocumentsDirectory();
}

// main() {
//   var getApplicationDocumentsDirectoryMock = getApplicationDocumentsDirectoryMock();
//   // var hiveMock = HiveMock();
//   // var boxMock = BoxMock();

//   setUpAll(() {
//     WidgetsFlutterBinding.ensureInitialized();

//     when(getApplicationDocumentsDirectoryMock()).thenAnswer(
//       (_) async => Directory('/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'),
//     );
//   });

//   test("Should return '/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'", () async {
//     Directory result = await getApplicationDocumentsDirectoryMock();

//     expect(result.path, equals('/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'));
//   });

  // test("Should initialize Hive", () async {
  //   when(hiveMock.openBox('testBox')).thenAnswer((_) async => boxMock);

  //   Directory directoryMock = await getApplicationDocumentsDirectoryMock();

  //   hiveMock.init(directoryMock.path);

  //   expect(await hiveMock.openBox('testBox'), isA<BoxMock>());
  // });

