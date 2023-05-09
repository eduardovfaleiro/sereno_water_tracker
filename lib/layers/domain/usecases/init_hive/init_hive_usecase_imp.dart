import '../../../repositories/init_hive_repository.dart';
import 'init_hive_usecase.dart';

class InitHiveUseCaseImp implements InitHiveUseCase {
  final InitHiveRepository _initHiveRepository;

  InitHiveUseCaseImp(this._initHiveRepository);

  @override
  Future<void> call() async {
    await _initHiveRepository();
  }
}
