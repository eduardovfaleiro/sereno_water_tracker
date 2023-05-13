import 'package:hive/hive.dart';

abstract interface class OpenHiveBox {
  Future<Box> call();
}
