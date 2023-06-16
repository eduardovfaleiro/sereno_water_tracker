import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/repositories/weight_repository.dart';
import '../datasources/weight_datasource.dart';

class WeightRepositoryImp implements WeightRepository {
  final WeightDataSource _weightRepositoryDataSource;

  WeightRepositoryImp(this._weightRepositoryDataSource);

  @override
  Future<Result<void>> update(double weight) async {
    try {
      return Right(await _weightRepositoryDataSource.update(weight));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
