import '../../../core/core.dart';

abstract interface class DailyGoalRepository {
  Future<Result<int>> get();
  Future<Result<int>> update(int amount);
  Future<Result<void>> create(int amount);
}
