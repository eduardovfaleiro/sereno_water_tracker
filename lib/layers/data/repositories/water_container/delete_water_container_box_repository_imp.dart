import 'package:hive/hive.dart';

import '../../../domain/repositories/water_container/delete_water_container_repository.dart';

class DeleteWaterContainerRepositoryImp implements DeleteWaterContainerRepository {
  @override
  Future<void> call(int waterContainerEntityIndex) async {
    await Hive.box('waterContainers').delete(waterContainerEntityIndex);
  }
}
