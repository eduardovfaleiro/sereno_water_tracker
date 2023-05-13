import 'package:hive/hive.dart';

import '../get_water_drank_today_datasource.dart';

class GetWaterDrankTodayDataSourceHiveImp implements GetWaterDrankTodayDataSource {
  @override
  double call() {
    return Hive.box('user').get('waterDrankToday');
  }
}
