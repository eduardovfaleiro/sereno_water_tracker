import 'package:hive/hive.dart';

abstract class OpenHiveBoxUseCase {
  Future<Box> call(String boxName);
}
