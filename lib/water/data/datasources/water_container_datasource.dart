import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/water_container_entity.dart';

abstract class WaterContainerDataSource {
  Future<List<WaterContainerEntity>> getAll();
  Future<void> add(WaterContainerEntity value);
  Future<void> remove(WaterContainerEntity value);
}

class HiveWaterContainerDataSource implements WaterContainerDataSource {
  final HiveInterface _hiveInterface;
  final Box _box;

  HiveWaterContainerDataSource(this._hiveInterface) : _box = _hiveInterface.box(WATER_CONTAINER);

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
    int containerIndex = _box.values.toList().indexWhere((e) => e == value);

    if (containerIndex == -1) {
      throw WaterContainerNotFoundException();
    }

    return _box.deleteAt(containerIndex);
  }
}
