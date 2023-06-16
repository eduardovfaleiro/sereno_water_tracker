import '../../../core/core.dart';

abstract interface class WeightRepository {
  Future<Result<void>> update(double weight);
}
