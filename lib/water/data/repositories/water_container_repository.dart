import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../datasources/water_container_datasource.dart';

abstract class WaterContainerRepository {
  Future<Result<List<WaterContainerEntity>>> getAll();
  Future<Result<void>> add(WaterContainerEntity value);
}

class WaterContainerRepositoryImp implements WaterContainerRepository {
  final WaterContainerDataSource _waterContainerDataSource;

  WaterContainerRepositoryImp(this._waterContainerDataSource);

  @override
  Future<Result<List<WaterContainerEntity>>> getAll() async {
    return Right(await _waterContainerDataSource.getAll());
  }

  // TODO: test
  @override
  Future<Result<void>> add(WaterContainerEntity value) async {
    return Right(await _waterContainerDataSource.add(value));
  }
}
