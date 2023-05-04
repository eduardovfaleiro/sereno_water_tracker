import 'package:hive/hive.dart';

abstract class OpenHiveBoxRepository {
  Future<Box> call(String boxName);
}
