import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_container_repository.dart';
import '../../domain/entities/water_container_entity.dart';

class WaterContainerController extends ChangeNotifier {
  List<WaterContainerEntity> waterContainers = [];

  final WaterContainerRepository _waterContainerRepository;

  WaterContainerController(this._waterContainerRepository);

  Future<void> init() async {
    final waterContainers = await getResult(_waterContainerRepository.getAll());
    if (waterContainers is Failure) throw Exception();

    this.waterContainers = waterContainers;
    notifyListeners();
  }

  Future<void> add(WaterContainerEntity waterContainerEntity) async {
    final addContainerResult = await _waterContainerRepository.add(waterContainerEntity);
    if (addContainerResult is Failure) throw Exception();

    waterContainers.add(waterContainerEntity);

    notifyListeners();
  }
}
