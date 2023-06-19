// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../enums/view_stage_enum.dart';

const FIRST = ViewStage.first;
const SECOND = ViewStage.second;
const THIRD = ViewStage.third;
const FOURTH = ViewStage.fourth;
const FIFTH = ViewStage.fifth;

class ViewStageViewModel extends ChangeNotifier {
  int numberOfStages;
  ViewStage _viewStage;

  ViewStageViewModel(this._viewStage, {required this.numberOfStages});

  void init({
    required ViewStage viewStage,
    required int numberOfStages,
  }) {
    _viewStage = viewStage;
    this.numberOfStages = numberOfStages;
  }

  ViewStage getViewStage() {
    return _viewStage;
  }

  Result<void> nextStage() {
    if (_viewStage == _lastViewStage) return Left(AlreadyLastStageFailure());

    _viewStage = ViewStage.values[_currentViewStageIndex + 1];

    return Right(notifyListeners());
  }

  Result<void> previousStage() {
    if (_viewStage == FIRST) return Left(AlreadyFirstStageFailure());

    _viewStage = ViewStage.values[_currentViewStageIndex - 1];

    return Right(notifyListeners());
  }

  ViewStage get _lastViewStage {
    return ViewStage.values[numberOfStages - 1];
  }

  int get _currentViewStageIndex {
    return ViewStage.values.indexWhere((stage) => stage == _viewStage);
  }
}
