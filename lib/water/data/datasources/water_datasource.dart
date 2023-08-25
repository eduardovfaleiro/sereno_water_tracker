import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
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
}

class HiveWaterDataSource implements WaterDataSource {
  final HiveInterface _hiveInterface;
  late final Box _box;

  HiveWaterDataSource(this._hiveInterface) {
    _box = _hiveInterface.box(WATER);
  }

  @override
  Future<int> getDailyDrinkingFrequency() async {
    return _box.get(DAILY_DRINKING_FREQUENCY);
  }

  @override
  Future<int> getDailyDrinkingGoal() async {
    return _box.get(DAILY_DRINKING_GOAL);
  }

  @override
  Future<int> getDrankToday() async {
    return _box.get(WATER_DRANK_TODAY);
  }

  @override
  Future<void> setDailyDrinkingFrequency(int value) async {
    await _box.put(DAILY_DRINKING_FREQUENCY, value);
  }

  @override
  Future<void> setDailyDrinkingGoal(int value) async {
    await _box.put(DAILY_DRINKING_GOAL, value);
  }

  @override
  Future<void> setDrankToday(int value) async {
    await _box.put(WATER_DRANK_TODAY, value);
  }

  @override
  Future<void> setTimesToDrink(List<TimeOfDay> value) async {
    List<String> timesToDrink = value.map((time) => TimeOfDayUtils(time).toLiteral()).cast<String>().toList();

    await _box.put(TIMES_TO_DRINK, timesToDrink);
  }

  @override
  Future<List<TimeOfDay>> getTimesToDrink() async {
    List<String> timesToDrink = _box.get(TIMES_TO_DRINK);

    return timesToDrink.map((time) => TimeOfDayUtils.fromString(time)).cast<TimeOfDay>().toList();
  }

  @override
  Future<DateTime?> getLastDrankTodayReset() async {
    return _box.get(LAST_WATER_DRANK_TODAY_RESET);
  }

  @override
  Future<void> setLastDrankTodayReset(DateTime value) async {
    return _box.put(LAST_WATER_DRANK_TODAY_RESET, value);
  }
}
