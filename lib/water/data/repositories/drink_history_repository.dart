import '../datasources/drink_history_datasource.dart';
import '../../domain/entities/drink_record_entity.dart';

abstract class DrinkHistoryRepository {
  Future<void> add(DrinkRecordEntity drinkRecordEntity);

  Future<void> remove(DrinkRecordEntity drinkRecordEntity);
  Future<void> removeAll();
}

class DrinkHistoryRepositoryImp implements DrinkHistoryRepository {
  final DrinkHistoryDataSource _dataSource;

  DrinkHistoryRepositoryImp(this._dataSource);

  @override
  Future<void> add(DrinkRecordEntity drinkRecordEntity) {
    return _dataSource.add(drinkRecordEntity);
  }

  @override
  Future<void> remove(DrinkRecordEntity drinkRecordEntity) {
    return _dataSource.remove(drinkRecordEntity);
  }

  @override
  Future<void> removeAll() {
    return _dataSource.removeAll();
  }
}
