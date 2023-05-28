import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';
import '../datasources/water_container/water_container_datasource.dart';
import '../dtos/water_container/water_container_dto.dart';

class WaterContainerRepositoryImp implements WaterContainerRepository {
  final WaterContainerDataSource _waterContainerDataSource;

  WaterContainerRepositoryImp(this._waterContainerDataSource);

  @override
  Future<int> create(WaterContainerEntity waterContainerEntity) {
    return _waterContainerDataSource.create(waterContainerEntity);
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(_waterContainerDataSource.delete(id));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, WaterContainerDto>> get(int id) async {
    try {
      var waterContainerDto = await _waterContainerDataSource.get(id);

      return Right(waterContainerDto);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<WaterContainerEntity>>> getAllContainers() async {
    try {
      return Right(await _waterContainerDataSource.getAllContainers());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
