import 'package:hive_flutter/hive_flutter.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/int_hive/init_hive_datasource.dart';

class InitHiveLocalDataSourceImp implements InitHiveDataSource {
  @override
  Future<void> call() async {
    await Hive.initFlutter();
  }
}
