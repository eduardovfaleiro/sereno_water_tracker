// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/enums/view_stage_enum.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/view_models/view_stage_view_model.dart';

void main() {
  group('getViewStage', () {
    int numberOfStages = 5;
    var viewStage = ViewStage.third;
    var viewStageViewModel = ViewStageViewModel(viewStage, numberOfStages: numberOfStages);

    test('Should return correct current ViewStage', () async {
      var result = viewStageViewModel.getViewStage();

      expect(result, viewStage);
    });
  });

  group('previousStage', () {
    int numberOfStages = 5;
    var viewStage = ViewStage.third;

    test('Should go to previous stage', () async {
      var viewStageViewModel = ViewStageViewModel(viewStage, numberOfStages: numberOfStages);

      viewStageViewModel.previousStage();

      expect(viewStageViewModel.getViewStage(), ViewStage.second);
    });

    test('Should return a AlreadyFirstStageFailure', () async {
      var firstViewStage = ViewStage.values.first;
      var viewStageViewModel = ViewStageViewModel(firstViewStage, numberOfStages: numberOfStages);

      var result = viewStageViewModel.previousStage();
      var expectedResult = result.fold((failure) => failure, (_) => null);

      expect(expectedResult, isA<AlreadyFirstStageFailure>());
    });
  });

  group('nextStage', () {
    int numberOfStages = 5;
    var viewStage = ViewStage.third;
    var viewStageViewModel = ViewStageViewModel(viewStage, numberOfStages: numberOfStages);

    test('Should go to next stage', () async {
      viewStageViewModel.nextStage();

      expect(viewStageViewModel.getViewStage(), ViewStage.fourth);
    });

    test('Should return a AlreadyLastStageFailure', () async {
      var lastViewStage = ViewStage.values.last;
      var viewStageViewModel = ViewStageViewModel(lastViewStage, numberOfStages: numberOfStages);

      var result = viewStageViewModel.nextStage();
      var expectedResult = result.fold((failure) => failure, (_) => null);

      expect(expectedResult, isA<AlreadyLastStageFailure>());
    });
  });
}
