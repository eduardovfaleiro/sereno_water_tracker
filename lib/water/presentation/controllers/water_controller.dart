import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/water_data_entity.dart';

class WaterController extends ChangeNotifier {
  bool isLoading = false;

  final WaterRepository _waterRepository;

  WaterController(this._waterRepository);

  late WaterDataEntity waterData;

  Future<void> init() async {
    isLoading = true;

    final waterDataResult = await getResult(_waterRepository.getWaterData());

    if (waterDataResult is Failure) throw Exception();

    waterData = waterDataResult.copyWith();

    isLoading = false;

    notifyListeners();
  }
}
