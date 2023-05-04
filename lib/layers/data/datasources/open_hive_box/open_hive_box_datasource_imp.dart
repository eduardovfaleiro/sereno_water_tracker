import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/open_hive_box/open_hive_box_datasource.dart';

class OpenHiveBoxLocalDataSourceImp implements OpenHiveBoxDataSource {
  @override
  Future<Box> call(String boxName) async {
    return await Hive.openBox(boxName);
  }
}
