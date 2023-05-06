import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/repositories/init_hive_repository.dart';

class InitHiveRepositoryImp implements InitHiveRepository {
  @override
  Future<void> call() async {
    Directory directory = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(directory.path);
  }
}
