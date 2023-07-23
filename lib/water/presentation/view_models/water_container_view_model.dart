import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/repositories/water_container_repository.dart';

abstract interface class WaterContainerViewModel extends ChangeNotifier {
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity);
  Future<Result<void>> update(WaterContainerEntity waterContainerEntity);
  Future<Result<List<WaterContainerEntity>>> getAllContainers();
  Future<Result<void>> delete(int id);
}

class WaterContainerViewModelImp extends ChangeNotifier implements WaterContainerViewModel {
  final WaterContainerRepository _waterContainerRepository;

  WaterContainerViewModelImp(this._waterContainerRepository);

  @override
  Future<Result<void>> create(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.create(waterContainerEntity).whenComplete(() => notifyListeners());
  }

  @override
  Future<Result<void>> delete(int id) {
    return _waterContainerRepository.delete(id);
  }

  @override
  Future<Result<List<WaterContainerEntity>>> getAllContainers() {
    return _waterContainerRepository.getAllContainers();
  }

  @override
  Future<Result<void>> update(WaterContainerEntity waterContainerEntity) {
    return _waterContainerRepository.update(waterContainerEntity);
  }
}
