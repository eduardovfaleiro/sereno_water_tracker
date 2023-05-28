import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract interface class AmountOfWaterDrankTodayRepository {
  Future<Either<Failure, int>> get();
  Future<Either<Failure, int>> update(int amount);
  Future<Either<Failure, int>> addUp(int amount);
}
