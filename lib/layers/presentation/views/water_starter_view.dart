library water_starter_view;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/theme/themes.dart';
import '../../../core/utils/functions/get_time_of_day_value.dart';
import '../view_models/save_user_view_model.dart';
import '../view_models/user_view_model.dart';
import '../view_models/water_view_model.dart';

part '../../../core/utils/functions/show_time_picker_waking_hours.dart';

class WaterStarterView extends StatelessWidget {
  const WaterStarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer<UserEntityViewModel>(
            builder: (context, userEntityViewModel, _) {
              return ListView(
                padding: const EdgeInsets.only(top: Spacing.big, left: Spacing.normal, right: Spacing.normal),
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: FontSize.small2,
                        color: Color.fromARGB(255, 226, 226, 226),
                        fontWeight: FontWeight.w500,
                      ),
                      text: 'Welcome to ',
                      children: [
                        TextSpan(
                          text: 'Sereno',
                          style: TextStyle(
                            color: Color(0xFF4E9CC8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: '!'),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.small2),
                  const Text(
                    'To get started, we need some information.',
                    style: TextStyle(
                      fontSize: FontSize.medium2,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 231, 231, 231),
                    ),
                  ),
                  const SizedBox(height: Spacing.big),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputCardWidget(
                        question: const MarkdownBody(data: "# What's your **weight**?"),
                        value: Text(
                          '${userEntityViewModel.weight} $MASS_UNIT_K',
                          style: const TextStyle(fontSize: FontSize.small1),
                        ),
                        slider: Slider(
                          max: MAX_WEIGHT.toDouble(),
                          min: MIN_WEIGHT.toDouble(),
                          value: userEntityViewModel.weight.toDouble(),
                          onChanged: (value) {
                            userEntityViewModel.updateWeight(value.toInt());
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      InputCardWidget(
                        question: const MarkdownBody(data: '# How **often** do you want to\ndrink a **day**?'),
                        value: Text('${userEntityViewModel.numberOfTimesToDrinkWaterDaily} times', style: const TextStyle(fontSize: FontSize.small1)),
                        slider: Slider(
                          max: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY.toDouble(),
                          divisions: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY,
                          value: userEntityViewModel.numberOfTimesToDrinkWaterDaily.toDouble(),
                          onChanged: (value) {
                            userEntityViewModel.updateNumberOfTimesToDrinkWaterDaily(value.toInt());
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      InputCardWidget(
                        question: const MarkdownBody(data: '# How **often** do you exercise\n# a **week**?'),
                        value: Text('${userEntityViewModel.weeklyWorkoutDays} days', style: const TextStyle(fontSize: FontSize.small1)),
                        slider: Slider(
                          max: DAYS_IN_A_WEEK.toDouble(),
                          divisions: DAYS_IN_A_WEEK,
                          value: userEntityViewModel.weeklyWorkoutDays.toDouble(),
                          onChanged: (value) {
                            userEntityViewModel.updateWeeklyWorkoutDays(value.toInt());
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      DateInputCardWidget(
                        onTap: () => showTimePickerWakingHours(context: context, userEntityViewModel: userEntityViewModel),
                        question: const MarkdownBody(data: '# What are your **waking** hours?'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small1, vertical: Spacing.small1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacing.small2,
                          horizontal: Spacing.small2,
                        ),
                      ),
                      onPressed: () async {
                        getIt<SaveUserViewModel>().updateUser(getIt<UserEntityViewModel>().getUserEntity()).then(
                          (result) {
                            result.fold((failure) {
                              if (failure is ValidationFailure) {
                                return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(failure.message),
                                ));
                              }
                            }, (success) async {
                              await getIt<WaterViewModel>().initializeData().whenComplete(() {
                                Navigator.pushReplacementNamed(context, '/waterDisplay');
                              });
                            });
                          },
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Finish',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: Spacing.small1),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: Spacing.small2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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

class DateInputCardWidget extends StatefulWidget {
  final Widget question;
  final void Function() onTap;

  const DateInputCardWidget({
    super.key,
    required this.onTap,
    required this.question,
  });

  @override
  State<DateInputCardWidget> createState() => _DateInputCardWidgetState();
}

class _DateInputCardWidgetState extends State<DateInputCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserEntityViewModel>(
      builder: (context, userEntityViewModel, _) {
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Spacing.small3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
              color: const Color(0xff0B131B),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.question,
                    const DatePickerMessage(),
                  ],
                ),
                const Icon(Icons.access_time_filled, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DatePickerMessage extends StatefulWidget {
  const DatePickerMessage({super.key});

  @override
  State<DatePickerMessage> createState() => _DatePickerMessageState();
}

class _DatePickerMessageState extends State<DatePickerMessage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserEntityViewModel>(builder: (context, userEntityViewModel, _) {
      if (userEntityViewModel.isUserValid) {
        return Text(
          'From ${getTimeOfDayValue(userEntityViewModel.wakeUpTime!)} to '
          '${getTimeOfDayValue(userEntityViewModel.sleepTime!)}',
          style: const TextStyle(fontSize: FontSize.small),
        );
      }

      return const Text(
        'Press to select time',
        style: TextStyle(color: Color.fromARGB(255, 83, 137, 192), fontSize: FontSize.small),
      );
    });
  }
}
