import 'package:clock/clock.dart';
import 'package:dart_date/dart_date.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';

abstract class TimeToDrinkAgainService {
  Future<Result<DateTime>> getNext();
  Future<String> getDrinkAgainInStr();
  Future<Duration> getDrinkAgainIn();
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
        final timeToDrink = now.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);

        if (now.isSameOrAfter(timeToDrink)) {
          return timeToDrink.addDays(1);
        }

        return timeToDrink;
      },
    ))!;

    return Right(closestToNow);
  }

  @override
  Future<String> getDrinkAgainInStr() async {
    final now = clock.now();
    Duration drinkAgainIn = await getDrinkAgainIn();

    DateTime timeToDrink = now.add(drinkAgainIn);

    return timeToDrink.timeago(locale: LOCALE);
  }

  @override
  Future<Duration> getDrinkAgainIn() async {
    final nextTimeToDrinkResult = await getResult(getNext());
    if (nextTimeToDrinkResult is Failure) throw Exception();

    DateTime nextTimeToDrink = nextTimeToDrinkResult;

    final now = clock.now();

    var currentDateTime = DateTime(1).copyWith(
      hour: now.hour,
      minute: now.minute,
    );

    var nextDateTimeToDrink = DateTime(1).copyWith(
      hour: nextTimeToDrink.hour,
      minute: nextTimeToDrink.minute,
    );

    if (currentDateTime.isAfter(nextDateTimeToDrink)) {
      nextDateTimeToDrink = nextDateTimeToDrink.addDays(1);
    }

    return nextDateTimeToDrink.difference(currentDateTime);
  }
}
