import 'package:hive/hive.dart';

abstract interface class CreateWaterContainerRepository {
  Future<Box> call();
}
