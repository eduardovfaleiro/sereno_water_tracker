// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/open_hive_box_repository.dart';

import '../datasources/open_hive_box/open_hive_box_datasource.dart';

class OpenHiveBoxRepositoryImp implements OpenHiveBoxRepository {
  final OpenHiveBoxDataSource _openHiveBoxDataSource;

  OpenHiveBoxRepositoryImp(this._openHiveBoxDataSource);

  @override
  Future<Box> call(String boxName) async {
    return await _openHiveBoxDataSource(boxName);
  }
}
