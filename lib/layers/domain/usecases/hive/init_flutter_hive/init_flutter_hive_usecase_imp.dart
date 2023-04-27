import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'init_flutter_hive_usecase.dart';

class InitFlutterHiveUseCaseImp implements InitFlutterHiveUseCase {
  @override
  Future<void> call() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }
}
