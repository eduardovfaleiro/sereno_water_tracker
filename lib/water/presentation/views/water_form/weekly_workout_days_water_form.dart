library water_starter_view;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/water_form_controller.dart';
import '../../widgets/number_picker.dart';

class WeeklyWorkoutDaysWaterForm extends StatelessWidget {
  const WeeklyWorkoutDaysWaterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: Spacing.small, left: Spacing.small, right: Spacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Treinamento', style: TextStyle(fontWeight: FontWeight.w600)),
              const Divider(
                height: Spacing.small3,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.medium1),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: FontSize.small2, color: MyColors.lightGrey),
                  text: 'Quantos dias você ',
                  children: [
                    TextSpan(
                      text: 'treina ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'em uma '),
                    TextSpan(
                      text: 'semana',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '?'),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: NumberPicker(
                  suffixWidget: Text(controller.user.weeklyWorkoutDays == 1 ? 'dia' : 'dias'),
                  range: DAYS_IN_A_WEEK,
                  initialValue: controller.user.weeklyWorkoutDays,
                  onChanged: (value) {
                    controller.setWeeklyWorkoutDays(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
 InputCardWidget(
                question: const MarkdownBody(data: '# Quantos dias você **treina**\nna **semana**?'),
                value: Text(
                    '${controller.user.weeklyWorkoutDays}'
                    ' ${controller.user.weeklyWorkoutDays == 1 ? 'dia' : 'dias'}',
                    style: const TextStyle(fontSize: FontSize.small1)),
                slider: Slider(
                  max: DAYS_IN_A_WEEK.toDouble(),
                  divisions: DAYS_IN_A_WEEK,
                  value: controller.user.weeklyWorkoutDays.toDouble(),
                  onChanged: (value) {
                    controller.setWeeklyWorkoutDays(value.toInt());
                  },
                ),
              ),*/