import 'package:clock/clock.dart';
import 'package:dart_date/dart_date.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';

abstract class HandleResetWaterDataUseCase {
  void call();
}

class HandleResetWaterDataUseCaseImp implements HandleResetWaterDataUseCase {
  final WaterRepository _waterRepository;

  HandleResetWaterDataUseCaseImp(this._waterRepository);

  @override
  Future<void> call() async {
    DateTime? lastTimeReset = await getResult(_waterRepository.getLastDrankTodayReset());

    if (lastTimeReset == null) {
      var setLastDrankTodayResetResult = await getResult(
        _waterRepository.setLastDrankTodayReset(clock.now()),
      );

      if (setLastDrankTodayResetResult is Failure) {
        throw Exception();
      }

      return;
    }

    if (lastTimeReset.isYesterday) {
      var setDrankTodayResult = await getResult(_waterRepository.setDrankToday(0));

      if (setDrankTodayResult is Failure) {
        throw Exception();
      }

      var setLastDrankTodayResetResult = await getResult(
        _waterRepository.setLastDrankTodayReset(clock.now()),
      );

      if (setLastDrankTodayResetResult is Failure) {
        throw Exception();
      }
    }
  }
}
