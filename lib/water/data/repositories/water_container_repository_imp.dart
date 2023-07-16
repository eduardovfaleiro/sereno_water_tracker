import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';
import '../datasources/water_container_datasource.dart';
import '../dtos/water_container/water_container_dto.dart';

class WaterContainerRepositoryImp implements WaterContainerRepository {
  final WaterContainerDataSource _waterContainerDataSource;

  WaterContainerRepositoryImp(this._waterContainerDataSource);

  @override
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity) async {
    return Right(_waterContainerDataSource.create(waterContainerEntity));
  }

  @override
  Future<Result<void>> delete(int id) async {
    return Right(_waterContainerDataSource.delete(id));
  }

  @override
  Future<Result<WaterContainerDto>> get(int id) async {
    var waterContainerDto = await _waterContainerDataSource.get(id);

    return Right(waterContainerDto);
  }

  @override
  Future<Result<List<WaterContainerEntity>>> getAllContainers() async {
    return Right(await _waterContainerDataSource.getAllContainers());
  }

  // TODO: test
  @override
  Future<Result<void>> update(WaterContainerDto waterContainerDto) async {
    return Right(await _waterContainerDataSource.update(waterContainerDto));
  }
}
