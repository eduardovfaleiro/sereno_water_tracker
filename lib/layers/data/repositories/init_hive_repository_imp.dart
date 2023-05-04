import 'package:sereno_clean_architecture_solid/layers/domain/repositories/init_hive_repository.dart';

import '../datasources/int_hive/init_hive_datasource.dart';

class InitHiveRepositoryImp implements InitHiveRepository {
  final InitHiveDataSource _initHiveDataSource;

  InitHiveRepositoryImp(this._initHiveDataSource);

  @override
  Future<void> call() async => await _initHiveDataSource();
}
