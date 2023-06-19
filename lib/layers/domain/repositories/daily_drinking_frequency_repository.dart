import '../../../core/core.dart';

abstract interface class TimesToDrinkPerDayRepository {
  Future<Result<int>> get();
}
