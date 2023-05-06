// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import '../../domain/repositories/open_hive_box_repository.dart';

class OpenHiveBoxRepositoryImp implements OpenHiveBoxRepository {
  OpenHiveBoxRepositoryImp();

  @override
  Future<Box> call(String boxName) async {
    return await Hive.openBox(boxName);
  }
}
