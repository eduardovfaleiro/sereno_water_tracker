import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/number_picker.dart';
import '../bottom_sheets.dart';

Future<void> showEditWeight({
  required BuildContext context,
  required Function(int weight) onOk,
  required int weight,
}) async {
  await BottomSheets.normal(
    context: context,
    title: 'Alterar peso',
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
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                child: NumberPicker(
                  initialValue: weight,
                  loop: true,
                  suffixWidget: const Text('kg'),
                  range: MAX_WEIGHT,
                  includeZero: false,
                  onChanged: (newWeight) {
                    setState(() {
                      weight = newWeight;
                    });
                  },
                ),
              ),
              const SizedBox(height: Spacing.small2),
              Button.ok(
                onPressed: () async {
                  onOk(weight);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
