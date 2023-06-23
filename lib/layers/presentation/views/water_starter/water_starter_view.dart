library water_starter_view;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../../core/utils/functions/get_time_of_day_value.dart';
import '../../../../core/utils/number_utils.dart';
import '../../view_models/user_view_model.dart';

part '../../../../core/utils/functions/show_time_picker_waking_hours.dart';
part 'widgets/date_input_card_widget.dart';
part 'widgets/input_card_widget.dart';

class WaterStarterView extends StatelessWidget {
  const WaterStarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer<UserViewModel>(
            builder: (context, userViewModel, _) {
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
                          '${NumberUtils(userViewModel.weight).roundByDecimalsToString()} $MASS_UNIT_K',
                          style: const TextStyle(fontSize: FontSize.small1),
                        ),
                        slider: Slider(
                          max: MAX_WEIGHT,
                          min: MIN_WEIGHT,
                          value: userViewModel.weight,
                          onChanged: (value) {
                            userViewModel.updateWeight(value);
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      InputCardWidget(
                        question: const MarkdownBody(data: '# How **often** do you want to\ndrink a **day**?'),
                        value: Text('${userViewModel.timesToDrinkPerDay} times', style: const TextStyle(fontSize: FontSize.small1)),
                        slider: Slider(
                          max: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY.toDouble(),
                          divisions: MAX_NUMBER_OF_TIMES_TO_DRINK_A_DAY,
                          value: userViewModel.timesToDrinkPerDay.toDouble(),
                          onChanged: (value) {
                            userViewModel.updateTimesToDrinkPerDay(value.toInt());
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      InputCardWidget(
                        question: const MarkdownBody(data: '# How **often** do you exercise\n# a **week**?'),
                        value: Text('${userViewModel.weeklyWorkoutDays} days', style: const TextStyle(fontSize: FontSize.small1)),
                        slider: Slider(
                          max: DAYS_IN_A_WEEK.toDouble(),
                          divisions: DAYS_IN_A_WEEK,
                          value: userViewModel.weeklyWorkoutDays.toDouble(),
                          onChanged: (value) {
                            userViewModel.updateWeeklyWorkoutDays(value.toInt());
                          },
                        ),
                      ),
                      const SizedBox(height: Spacing.small2),
                      DateInputCardWidget(
                        onTap: () => showTimePickerWakingHours(context: context, userViewModel: userViewModel),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/waterDisplay');
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Finish',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
