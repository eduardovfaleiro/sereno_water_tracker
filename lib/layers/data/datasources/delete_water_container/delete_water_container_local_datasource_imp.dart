import 'package:hive/hive.dart';

import 'delete_water_container_datasource.dart';

class DeleteWaterContainerLocalDataSourceImp implements DeleteWaterContainerDataSource {
  @override
  Future<void> call(int waterContainerEntityIndex) async {
    await Hive.box('waterContainers').delete(waterContainerEntityIndex);
  }
}
