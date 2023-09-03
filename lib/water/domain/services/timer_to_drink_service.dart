import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'time_to_drink_service.dart';

import '../../../core/core.dart';

abstract class TimerToDrinkService {
  void start();
  void cancel();

  ValueNotifier<Duration> get timeToDrink;
}

class TimerToDrinkServiceImp implements TimerToDrinkService {
  final TimeToDrinkAgainService _timeToDrinkAgainService;

  TimerToDrinkServiceImp(this._timeToDrinkAgainService);

  Timer? _timer;

  @override
  final timeToDrink = ValueNotifier<Duration>(Duration.zero);

  @override
  void cancel() {
    _timer!.cancel();
  }

  @override
  void start() async {
    DateTime nextTimeToDrink = await getResult(_timeToDrinkAgainService.getNext());

    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final now = clock.now();

      Duration difference = nextTimeToDrink.difference(now);

      if (difference.isNegative) {
        nextTimeToDrink = await getResult(_timeToDrinkAgainService.getNext());
      }

      timeToDrink.value = difference;
    });
  }
}
