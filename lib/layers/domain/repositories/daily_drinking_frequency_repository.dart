import '../../../core/core.dart';

abstract interface class DailyDrinkingFrequencyRepository {
  Future<Result<int>> get();
}
