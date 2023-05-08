import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class GetApplicationDocumentsDirectoryMock extends Mock {
  call();
}

main() {
  var getApplicationDocumentsDirectoryMock = GetApplicationDocumentsDirectoryMock();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();

    when(getApplicationDocumentsDirectoryMock()).thenAnswer(
      (_) async => Directory('/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'),
    );
  });

  test("Should return '/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'", () async {
    Directory result = await getApplicationDocumentsDirectoryMock();

    expect(result.path, equals('/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'));
  });

  test("Should initialize Hive", () async {
    Directory directoryMock = await getApplicationDocumentsDirectoryMock();

    Hive.init(directoryMock.path);

    expect(Hive.openBox('testeBox'), isA<Future<Box>>());

    Hive.close();
    Hive.deleteFromDisk();
  });

  test("Shouldn't find box", () async {
    Directory directoryMock = await getApplicationDocumentsDirectoryMock();

    Hive.init(directoryMock.path);

    expect(await Hive.boxExists('testeBox'), equals(false));
  });
}
