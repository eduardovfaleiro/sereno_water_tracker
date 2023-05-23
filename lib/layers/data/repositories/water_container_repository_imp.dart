import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';
import '../datasources/local/water_container/water_container_local_datasource.dart';
import '../dtos/water_container_dto.dart';

class WaterContainerRepositoryImp implements WaterContainerRepository {
  final WaterContainerLocalDataSource _waterContainerLocalDataSource;

  WaterContainerRepositoryImp(this._waterContainerLocalDataSource);

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    return _waterContainerLocalDataSource.create(waterContainerEntity);
  }

  @override
  Future<void> delete(int id) {
    return _waterContainerLocalDataSource.delete(id);
  }

  @override
  Future<Either<Failure, WaterContainerDto>> get(int id) async {
    try {
      var waterContainerDto = await _waterContainerLocalDataSource.get(id);

      return Right(waterContainerDto);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
