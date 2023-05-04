import 'package:hive/hive.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/hive/open_hive_box/open_hive_box_usecase.dart';

import '../../../repositories/open_hive_box_repository.dart';

class OpenHiveBoxUseCaseImp implements OpenHiveBoxUseCase {
  final OpenHiveBoxRepository _openHiveBoxRepository;

  OpenHiveBoxUseCaseImp(this._openHiveBoxRepository);

  @override
  Future<Box> call(String boxName) async {
    return await _openHiveBoxRepository(boxName);
  }
}
