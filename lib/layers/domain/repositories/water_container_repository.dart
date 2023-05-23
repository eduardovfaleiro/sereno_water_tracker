import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/water_container_entity.dart';

abstract interface class WaterContainerRepository {
  Future<Either<Failure, WaterContainerEntity>> get(int id);
  Future<int> create(WaterContainerEntity waterContainerEntity);
  Future<void> delete(int id);
}
