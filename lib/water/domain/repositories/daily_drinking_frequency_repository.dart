import '../../../core/core.dart';

abstract interface class NumberOfTimesToDrinkWaterDailyRepository {
  Future<Result<int>> get();
  Future<Result<void>> update(int times);
}
