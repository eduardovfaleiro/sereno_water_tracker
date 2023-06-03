import '../../../core/core.dart';

abstract interface class AmountOfWaterDrankTodayRepository {
  Future<Result<int>> get();
  Future<Result<int>> update(int amount);
  Future<Result<int>> addUp(int amount);
}
