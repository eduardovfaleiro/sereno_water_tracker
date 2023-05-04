import 'package:hive/hive.dart';

abstract class OpenHiveBoxDataSource {
  Future<Box> call(String boxName);
}
