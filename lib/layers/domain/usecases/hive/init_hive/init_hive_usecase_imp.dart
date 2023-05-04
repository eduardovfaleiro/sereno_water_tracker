import '../../../repositories/init_hive_repository.dart';
import '../../init_hive/init_hive/init_hive_usecase.dart';
import '../open_hive_box/open_hive_box_usecase.dart';

class InitHiveUseCaseImp implements InitHiveUseCase {
  final InitHiveRepository _initHiveRepositoryImp;
  final List<OpenHiveBoxUseCase> _openHiveBoxImpList;

  InitHiveUseCaseImp({
    required List<OpenHiveBoxUseCase> openHiveBoxList,
    required InitHiveRepository initHiveRepository,
  })  : _openHiveBoxImpList = openHiveBoxList,
        _initHiveRepositoryImp = initHiveRepository;

  @override
  Future<void> call() async {
    await _initHiveRepositoryImp();

    for (OpenHiveBoxUseCase openHiveBoxImp in _openHiveBoxImpList) {
      await openHiveBoxImp();
    }
  }
}
