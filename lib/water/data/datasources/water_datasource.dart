import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/functions/time_of_day_utils.dart';

abstract class WaterDataSource {
  Future<int> getDrankToday();
  Future<int> getDailyDrinkingGoal();
  Future<int> getDailyDrinkingFrequency();
  Future<List<TimeOfDay>> getTimesToDrink();
  Future<DateTime?> getLastDrankTodayReset();

  Future<void> setDrankToday(int value);
  Future<void> setDailyDrinkingGoal(int value);
  Future<void> setDailyDrinkingFrequency(int value);
  Future<void> setTimesToDrink(List<TimeOfDay> value);
  Future<void> setLastDrankTodayReset(DateTime value);

  Future<void> deleteTimeToDrink(TimeOfDay value);
  Future<void> updateTimeToDrink(TimeOfDay key, TimeOfDay newValue);
  Future<void> addTimeToDrink(TimeOfDay value);
}

class HiveWaterDataSource implements WaterDataSource {
  final HiveInterface _hiveInterface;

  HiveWaterDataSource(this._hiveInterface);
  @override
  Future<int> getDailyDrinkingFrequency() async {
    return _hiveInterface.box(WATER).get(DAILY_DRINKING_FREQUENCY);
  }

  @override
  Future<int> getDailyDrinkingGoal() async {
    return _hiveInterface.box(WATER).get(DAILY_DRINKING_GOAL);
  }

  @override
  Future<int> getDrankToday() async {
    return _hiveInterface.box(WATER).get(WATER_DRANK_TODAY);
  }

  @override
  Future<void> setDailyDrinkingFrequency(int value) async {
    await _hiveInterface.box(WATER).put(DAILY_DRINKING_FREQUENCY, value);
  }

  @override
  Future<void> setDailyDrinkingGoal(int value) async {
    await _hiveInterface.box(WATER).put(DAILY_DRINKING_GOAL, value);
  }

  @override
  Future<void> setDrankToday(int value) async {
    await _hiveInterface.box(WATER).put(WATER_DRANK_TODAY, value);
  }

  @override
  Future<void> setTimesToDrink(List<TimeOfDay> value) async {
    List<String> timesToDrink = value.map((time) => TimeOfDayUtils(time).toLiteral()).cast<String>().toList();

    await _hiveInterface.box(WATER).put(TIMES_TO_DRINK, timesToDrink);
  }

  @override
  Future<List<TimeOfDay>> getTimesToDrink() async {
    List<String> timesToDrink = _hiveInterface.box(WATER).get(TIMES_TO_DRINK);

    return timesToDrink.map((time) => TimeOfDayUtils.fromString(time)).cast<TimeOfDay>().toList();
  }

  @override
  Future<DateTime?> getLastDrankTodayReset() async {
    return _hiveInterface.box(WATER).get(LAST_WATER_DRANK_TODAY_RESET);
  }

  @override
  Future<void> setLastDrankTodayReset(DateTime value) async {
    return _hiveInterface.box(WATER).put(LAST_WATER_DRANK_TODAY_RESET, value);
  }

  @override
  Future<void> deleteTimeToDrink(TimeOfDay value) {
    List<String> timesToDrink = _hiveInterface.box(WATER).get(TIMES_TO_DRINK);

    timesToDrink.removeWhere((timeToDrink) => timeToDrink == TimeOfDayUtils(value).toLiteral());

    return _hiveInterface.box(WATER).put(TIMES_TO_DRINK, timesToDrink);
  }

  @override
  Future<void> updateTimeToDrink(TimeOfDay key, TimeOfDay newValue) async {
    List<String> timesToDrink = _hiveInterface.box(WATER).get(TIMES_TO_DRINK);

    int index = timesToDrink.indexWhere((timeToDrink) => timeToDrink == TimeOfDayUtils(key).toLiteral());

    if (timesToDrink.contains(TimeOfDayUtils(newValue).toLiteral()) && newValue != key) {
      throw TimeToDrinkAlreadyExistsException();
    }

    timesToDrink[index] = TimeOfDayUtils(newValue).toLiteral();
  }

  @override
  Future<void> addTimeToDrink(TimeOfDay value) async {
    List<String> timesToDrink = _hiveInterface.box(WATER).get(TIMES_TO_DRINK);

    if (timesToDrink.map((e) => TimeOfDayUtils.fromString(e)).contains(value)) {
      throw TimeToDrinkAlreadyExistsException();
    }

    timesToDrink.add(TimeOfDayUtils(value).toLiteral());

    _hiveInterface.box(WATER).put(TIMES_TO_DRINK, timesToDrink);
  }
}
