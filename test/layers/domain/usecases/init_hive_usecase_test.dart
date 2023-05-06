import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

main() {
  test("Shouldn't throw error", () async {
    WidgetsFlutterBinding.ensureInitialized();

    Directory directory = await getApplicationDocumentsDirectory();

    expect(() => Hive.init(directory.path), throwsA(isA<MissingPluginException>()));
  });
}
