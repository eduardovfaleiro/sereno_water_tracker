import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/number_picker.dart';
import '../bottom_sheets.dart';

Future<void> showEditDailyDrinkingFrequency({
  required BuildContext context,
  required Function(int dailyDrinkingFrequency) onOk,
  required int dailyDrinkingFrequency,
}) async {
  await BottomSheets.normal(
    context: context,
    title: 'Alterar quantas vezes beber ao dia',
    content: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small2,
            vertical: Spacing.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: NumberPicker(
                  suffixWidget: Text(dailyDrinkingFrequency == 1 ? 'vez' : 'vezes'),
                  range: MAX_DAILY_DRINKING_FREQUENCY,
                  includeZero: false,
                  initialValue: dailyDrinkingFrequency,
                  onChanged: (newDailyDrinkingFrequency) {
                    setState(() {
                      dailyDrinkingFrequency = newDailyDrinkingFrequency;
                    });
                  },
                ),
              ),
              const SizedBox(height: Spacing.small2),
              Button.ok(
                onPressed: () async {
                  onOk(dailyDrinkingFrequency);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
