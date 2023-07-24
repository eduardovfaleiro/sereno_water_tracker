import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';
import '../datasources/water_container_datasource.dart';

class WaterContainerRepositoryImp implements WaterContainerRepository {
  final WaterContainerDataSource _waterContainerDataSource;

  WaterContainerRepositoryImp(this._waterContainerDataSource);

  @override
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity) async {
    return Right(_waterContainerDataSource.create(waterContainerEntity));
  }

  @override
  Future<Result<void>> delete(WaterContainerEntity waterContainerEntity) async {
    return Right(_waterContainerDataSource.delete(waterContainerEntity));
  }

  @override
  Future<Result<WaterContainerEntity>> get(int id) async {
    var waterContainerEntity = await _waterContainerDataSource.get(id);

    return Right(waterContainerEntity);
  }

  @override
  Future<Result<List<WaterContainerEntity>>> getAllContainers() async {
    return Right(await _waterContainerDataSource.getAllContainers());
  }

  // TODO: test
  @override
  Future<Result<void>> update(WaterContainerEntity waterContainerEntity) async {
    return Right(await _waterContainerDataSource.update(waterContainerEntity));
  }
}
