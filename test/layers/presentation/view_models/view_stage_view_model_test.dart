// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/enums/view_stage_enum.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/view_models/view_stage_view_model.dart';

void main() {
  group('previousStage', () {
    int numberOfStages = 5;
    var viewStage = ValueNotifier(ViewStage.third);

    test('Should go to previous stage', () async {
      var viewStageViewModel = ViewStageViewModel(stage: viewStage, numberOfStages: numberOfStages);

      viewStageViewModel.previousStage();

      expect(viewStageViewModel.stage.value, ViewStage.second);
    });

    test('Should do nothing', () async {
      var firstViewStage = ValueNotifier(ViewStage.values.first);
      var viewStageViewModel = ViewStageViewModel(stage: firstViewStage, numberOfStages: numberOfStages);

      viewStageViewModel.previousStage();

      expect(firstViewStage, viewStageViewModel.stage);
    });
  });

  group('nextStage', () {
    int numberOfStages = 5;
    var viewStage = ValueNotifier(ViewStage.third);
    var viewStageViewModel = ViewStageViewModel(stage: viewStage, numberOfStages: numberOfStages);

    test('Should go to next stage', () async {
      viewStageViewModel.nextStage();

      expect(viewStageViewModel.stage.value, ViewStage.fourth);
    });

    test('Should do nothing', () async {
      var lastViewStage = ValueNotifier(ViewStage.values.last);
      var viewStageViewModel = ViewStageViewModel(stage: lastViewStage, numberOfStages: numberOfStages);

      viewStageViewModel.nextStage();

      expect(lastViewStage, viewStageViewModel.stage);
    });
  });
}
