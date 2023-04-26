import 'package:hive_flutter/hive_flutter.dart';

abstract class OpenHiveBox {
  Future<Box> call();
}
