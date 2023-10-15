import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/water_container_entity.dart';

abstract class WaterContainerDataSource {
  Future<List<WaterContainerEntity>> getAll();
  Future<void> add(WaterContainerEntity value);
  Future<void> remove(WaterContainerEntity value);
  Future<void> removeAll();
}

class HiveWaterContainerDataSource implements WaterContainerDataSource {
  final Box _box;

  HiveWaterContainerDataSource(HiveInterface hiveInterface) : _box = hiveInterface.box(WATER_CONTAINER);

  @override
  Future<List<WaterContainerEntity>> getAll() async {
    return _box.values.cast<WaterContainerEntity>().toList();
  }

  @override
  Future<void> add(WaterContainerEntity value) async {
    await _box.add(value);
  }

  @override
  Future<void> remove(WaterContainerEntity value) async {
    int containerIndex = _box.values.toList().indexWhere((e) => e == value); // TODO: tá dando bo

    if (containerIndex == -1) {
      throw WaterContainerNotFoundException();
    }

    return _box.deleteAt(containerIndex);
  }

  @override
  Future<void> removeAll() async {
    await _box.clear();
  }
}
