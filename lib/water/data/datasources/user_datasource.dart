import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/core.dart';
import '../../../core/functions/time_of_day_utils.dart';
import '../../domain/entities/sleep_habit_entity.dart';

abstract class UserDataSource {
  Future<int> getWeight();
  Future<TimeOfDay> getSleeptime();
  Future<TimeOfDay> getWakeUpTime();
  Future<int> getWeeklyWorkoutDays();
  Future<SleepHabitEntity> getSleepHabit();

  Future<void> setWeight(int value);
  Future<void> setSleeptime(TimeOfDay value);
  Future<void> setWakeUpTime(TimeOfDay value);
  Future<void> setWeeklyWorkoutDays(int value);
  Future<void> setSleepHabit(SleepHabitEntity value);
}

class HiveUserDataSource implements UserDataSource {
  final HiveInterface _hiveInterface;
  late final Box _box;

  HiveUserDataSource(this._hiveInterface) {
    _box = _hiveInterface.box(USER);
  }

  @override
  Future<SleepHabitEntity> getSleepHabit() async {
    String wakeUpTimeStr = _box.get(WAKE_UP_TIME);
    String sleeptimeStr = _box.get(SLEEPTIME);

    return SleepHabitEntity(
      wakeUpTime: TimeOfDayUtils.fromString(wakeUpTimeStr),
      sleeptime: TimeOfDayUtils.fromString(sleeptimeStr),
    );
  }

  @override
  Future<TimeOfDay> getSleeptime() async {
    List<String> sleeptime = _box.get(SLEEPTIME).split(':');

    return TimeOfDay(
      hour: int.parse(sleeptime.first),
      minute: int.parse(sleeptime.last),
    );
  }

  @override
  Future<TimeOfDay> getWakeUpTime() async {
    List<String> wakeUpTime = _box.get(WAKE_UP_TIME).split(':');

    return TimeOfDay(
      hour: int.parse(wakeUpTime.first),
      minute: int.parse(wakeUpTime.last),
    );
  }

  @override
  Future<int> getWeeklyWorkoutDays() async {
    return _box.get(WEEKLY_WORKOUT_DAYS);
  }

  @override
  Future<int> getWeight() async {
    return _box.get(WEIGHT);
  }

  @override
  Future<void> setSleepHabit(SleepHabitEntity value) async {
    await _box.put(SLEEPTIME, TimeOfDayUtils(value.sleeptime).toLiteral());
    await _box.put(WAKE_UP_TIME, TimeOfDayUtils(value.wakeUpTime).toLiteral());
  }

  @override
  Future<void> setSleeptime(TimeOfDay value) async {
    await _box.put(SLEEPTIME, TimeOfDayUtils(value).toLiteral());
  }

  @override
  Future<void> setWakeUpTime(TimeOfDay value) async {
    await _box.put(WAKE_UP_TIME, TimeOfDayUtils(value).toLiteral());
  }

  @override
  Future<void> setWeeklyWorkoutDays(int value) async {
    await _box.put(WEEKLY_WORKOUT_DAYS, value);
  }

  @override
  Future<void> setWeight(int value) async {
    await _box.put(WEIGHT, value);
  }
}
