import 'package:hive/hive.dart';

import '../../domain/repositories/open_hive_boxes_repository.dart';

class OpenHiveBoxesRepositoryImp implements OpenHiveBoxesRepository {
  final List<String> boxesNames;

  OpenHiveBoxesRepositoryImp(this.boxesNames);

  @override
  Future<void> call() async {
    for (String boxName in boxesNames) {
      Hive.openBox(boxName);
    }
  }
}
