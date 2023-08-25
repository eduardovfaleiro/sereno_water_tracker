import 'dart:async';

import '../usecases/handle_reset_water_data_usecase.dart';

abstract class ResetDataWithTimerService {
  void startWater();
  void stopWater();
}

class ResetDataWithTimerServiceImp implements ResetDataWithTimerService {
  late final Timer _waterTimer;

  final HandleResetWaterDataUseCase _handleResetWaterDataUseCase;

  ResetDataWithTimerServiceImp(this._handleResetWaterDataUseCase);

  @override
  void startWater() {
    _waterTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _handleResetWaterDataUseCase();
    });
  }

  @override
  void stopWater() {
    _waterTimer.cancel();
  }
}
