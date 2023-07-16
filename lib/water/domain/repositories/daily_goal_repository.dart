import '../../../core/core.dart';

abstract interface class DailyDrinkingGoalRepository {
  Future<Result<int>> get();
  Future<Result<void>> update(int amount);
}
