import 'package:clock/clock.dart';
import 'package:dart_date/dart_date.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';

abstract class TimeToDrinkAgainService {
  Future<Result<DateTime>> getNext();
}

class TimeToDrinkAgainServiceImp implements TimeToDrinkAgainService {
  final WaterRepository _waterRepository;

  TimeToDrinkAgainServiceImp(this._waterRepository);

  @override
  Future<Result<DateTime>> getNext() async {
    final now = clock.now();

    final timesToDrinkResult = await getResult(_waterRepository.getTimesToDrink());
    if (timesToDrinkResult is Failure) return Left(timesToDrinkResult);

    List<TimeOfDay> timesToDrink = timesToDrinkResult;

    DateTime closestToNow = now.closestTo(timesToDrink.map(
      (timeOfDay) {
        final timeToDrink = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

        if (now.isSameOrAfter(timeToDrink)) {
          return timeToDrink.addDays(1);
        }

        return timeToDrink;
      },
    ))!;

    return Right(closestToNow);
  }
}
