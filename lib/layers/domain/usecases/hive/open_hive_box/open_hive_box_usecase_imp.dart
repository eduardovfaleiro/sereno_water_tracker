import 'package:hive/hive.dart';

import '../../../repositories/open_hive_box_repository.dart';
import 'open_hive_box_usecase.dart';

class OpenHiveBoxUseCaseImp implements OpenHiveBoxUseCase {
  final OpenHiveBoxRepository _openHiveBoxRepository;

  OpenHiveBoxUseCaseImp(this._openHiveBoxRepository);

  @override
  Future<Box> call(String boxName) async {
    return await _openHiveBoxRepository(boxName);
  }
}
