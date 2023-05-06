// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../repositories/open_hive_boxes_repository.dart';
import 'open_hive_boxes_usecase.dart';

class OpenHiveBoxesUseCaseImp implements OpenHiveBoxesUseCase {
  final OpenHiveBoxesRepository _openHiveBoxesRepository;

  OpenHiveBoxesUseCaseImp(this._openHiveBoxesRepository);

  @override
  Future<void> call() async {
    await _openHiveBoxesRepository();
  }
}
