import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../../core/utils/number_utils.dart';
import '../../view_models/user_view_model.dart';
import '../../view_models/view_stage_view_model.dart';

class WaterStarterView extends StatelessWidget {
  WaterStarterView({super.key});

  final _viewStageViewModel = getIt<ViewStageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewStageViewModel>(
      builder: (context, viewStageViewModel, _) {
        return Scaffold(
            body: SafeArea(
              child: Consumer<UserViewModel>(
                builder: (context, userViewModel, _) {
                  return Padding(
                    padding: const EdgeInsets.all(Spacing.normal),
                    child: ListView(
                      children: [
                        const LinearProgressIndicator(value: 0.5),
                        const SizedBox(height: Spacing.big),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: FontSize.small3,
                              color: Color.fromARGB(255, 226, 226, 226),
                              fontWeight: FontWeight.w500,
                            ),
                            text: 'Welcome to ',
                            children: [
                              TextSpan(
                                text: 'Sereno',
                                style: TextStyle(
                                  color: Color(0xff4E9CC8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: '!'),
                            ],
                          ),
                        ),
                        const SizedBox(height: Spacing.small3),
                        const Text(
                          'To get started, we need some information.',
                          style: TextStyle(
                            fontSize: FontSize.medium2,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 231, 231, 231),
                          ),
                        ),
                        const SizedBox(height: Spacing.big),
                        (viewStageViewModel.getViewStage() == FIRST) ? _FirstStage() : _SecondStage(),
                      ],
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: _StagesButtons(_viewStageViewModel));
      },
    );
  }
}

class _StagesButtons extends StatelessWidget {
  final ViewStageViewModel _viewStageViewModel;

  const _StagesButtons(this._viewStageViewModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small1, vertical: Spacing.small1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: _viewStageViewModel.getViewStage() != FIRST,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacing.small2,
                          horizontal: Spacing.small3,
                        ),
                        backgroundColor: const Color.fromARGB(255, 201, 132, 132),
                      ),
                      onPressed: () {
                        _viewStageViewModel.previousStage();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                          SizedBox(width: Spacing.small),
                          Text(
                            'Previous',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: FontSize.small2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Spacing.small3),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacing.small2,
                    horizontal: Spacing.small3,
                  ),
                  backgroundColor: const Color.fromARGB(255, 138, 201, 132),
                ),
                onPressed: () {
                  _viewStageViewModel.nextStage();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: FontSize.small2),
                    ),
                    SizedBox(width: Spacing.small),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondStage extends StatelessWidget {
  final userViewModel = getIt<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputCardWidget(
          question: const MarkdownBody(data: "# When do you **usually** **wake up**?"),
          value: const Text(
            '8:00',
            style: TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1),
          ),
          slider: Slider(
            max: MAX_WEIGHT.toDouble(),
            value: userViewModel.weight,
            onChanged: (value) {
              userViewModel.updateWeight(value);
            },
          ),
        ),
        const SizedBox(height: Spacing.small3),
        InputCardWidget(
          question: const MarkdownBody(data: '# When do you **usually** go **sleep**?'),
          value: const Text('22:00', style: TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1)),
          slider: Slider(
            max: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY.toDouble(),
            divisions: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY,
            value: userViewModel.timesToDrinkPerDay.toDouble(),
            onChanged: (value) {
              userViewModel.updateTimesToDrinkPerDay(value.toInt());
            },
          ),
        ),
      ],
    );
  }
}

class _FirstStage extends StatelessWidget {
  final userViewModel = getIt<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputCardWidget(
          question: const MarkdownBody(data: "# What's your **weight**?"),
          value: Text(
            '${NumberUtils(userViewModel.weight).roundByDecimalsToString()} $MASS_UNIT_K',
            style: const TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1),
          ),
          slider: Slider(
            max: MAX_WEIGHT.toDouble(),
            value: userViewModel.weight,
            onChanged: (value) {
              userViewModel.updateWeight(value);
            },
          ),
        ),
        const SizedBox(height: Spacing.small3),
        InputCardWidget(
          question: const MarkdownBody(data: '# How **often** to drink a **day**?'),
          value: Text('${userViewModel.timesToDrinkPerDay} times', style: const TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1)),
          slider: Slider(
            max: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY.toDouble(),
            divisions: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY,
            value: userViewModel.timesToDrinkPerDay.toDouble(),
            onChanged: (value) {
              userViewModel.updateTimesToDrinkPerDay(value.toInt());
            },
          ),
        ),
        const SizedBox(height: Spacing.small3),
        InputCardWidget(
          question: const MarkdownBody(data: '# How **often** do you exercise\n# a **week**?'),
          value: Text('${userViewModel.weeklyWorkoutDays} days', style: const TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1)),
          slider: Slider(
            max: DAYS_IN_A_WEEK.toDouble(),
            divisions: DAYS_IN_A_WEEK,
            value: userViewModel.weeklyWorkoutDays.toDouble(),
            onChanged: (value) {
              userViewModel.updateWeeklyWorkoutDays(value.toInt());
            },
          ),
        ),
      ],
    );
  }
}

class InputCardWidget extends StatefulWidget {
  final Widget question;
  final Widget value;
  final Slider slider;

  const InputCardWidget({
    super.key,
    required this.question,
    required this.value,
    required this.slider,
  });

  @override
  State<InputCardWidget> createState() => _InputCardWidgetState();
}

class _InputCardWidgetState extends State<InputCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.small3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        color: const Color(0xff0B131B),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.question,
              widget.value,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.normal, bottom: Spacing.small2),
            child: widget.slider,
          ),
        ],
      ),
    );
  }
}
