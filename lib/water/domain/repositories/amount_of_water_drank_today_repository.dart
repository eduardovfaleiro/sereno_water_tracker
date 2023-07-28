import '../../../core/core.dart';

abstract interface class AmountOfWaterDrankTodayRepository {
  Future<Result<int>> get();
  Future<Result<void>> update(int amount);
  Future<Result<void>> addUp(int amount);
  Future<Result<void>> remove(int amount);
}
