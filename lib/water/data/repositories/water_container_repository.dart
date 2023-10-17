import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../datasources/water_container_datasource.dart';

abstract class WaterContainerRepository {
  Future<Result<List<WaterContainerEntity>>> getAll();
  Future<Result<void>> add(WaterContainerEntity value);
  Future<Result<void>> remove(WaterContainerEntity value);
  Future<Result<void>> removeAll();
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

  // TODO: test
  @override
  Future<Result<void>> remove(WaterContainerEntity value) async {
    return Right(await _waterContainerDataSource.remove(value));
  }

  @override
  Future<Result<void>> removeAll() async {
    return Right(await _waterContainerDataSource.removeAll());
  }
}
