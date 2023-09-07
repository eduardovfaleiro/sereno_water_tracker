library water_starter_view;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../../core/theme/themes.dart';
import '../../../controllers/water_form_controller.dart';
import '../../../widgets/number_picker.dart';

class DailyFrequencyWaterForm extends StatelessWidget {
  const DailyFrequencyWaterForm({super.key});

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
              const Text('Frequência', style: TextStyle(fontWeight: FontWeight.w600)),
              const Divider(
                height: Spacing.small3,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.medium1),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: FontSize.small2, color: MyColors.lightGrey),
                  text: 'Quantas vezes deseja ser ',
                  children: [
                    TextSpan(
                      text: 'notificado ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' para beber por '),
                    TextSpan(
                      text: 'dia',
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
                  suffixWidget: Text(controller.waterData.dailyDrinkingFrequency == 1 ? 'vez' : 'vezes'),
                  range: MAX_DAILY_DRINKING_FREQUENCY,
                  includeZero: false,
                  initialValue: controller.waterData.dailyDrinkingFrequency,
                  onChanged: (value) {
                    controller.setDailyDrinkingFrequency(value);
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
