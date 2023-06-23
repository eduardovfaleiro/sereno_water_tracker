// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../enums/view_stage_enum.dart';

const FIRST = ViewStage.first;
const SECOND = ViewStage.second;
const THIRD = ViewStage.third;
const FOURTH = ViewStage.fourth;
const FIFTH = ViewStage.fifth;

class ViewStageViewModel {
  final int numberOfStages;
  ValueNotifier<ViewStage> stage;

  ViewStageViewModel({required this.stage, required this.numberOfStages});

  void nextStage() {
    if (stage.value == _lastViewStage) return;

    stage.value = ViewStage.values[_currentViewStageIndex + 1];
  }

  void previousStage() {
    if (stage.value == FIRST) return;

    stage.value = ViewStage.values[_currentViewStageIndex - 1];
  }

  ViewStage get _lastViewStage {
    return ViewStage.values[numberOfStages - 1];
  }

  int get _currentViewStageIndex {
    return ViewStage.values.indexWhere((stage) => this.stage.value == stage);
  }
}
