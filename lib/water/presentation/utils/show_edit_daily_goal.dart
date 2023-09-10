import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';
import '../widgets/buttons/button.dart';
import '../widgets/my_text_fields.dart';
import 'bottom_sheets.dart';

Future<void> showEditDailyGoalBottomSheet({
  required BuildContext context,
  required Function(int dailyGoal) onOk,
}) async {
  int? amount;
  final formKey = GlobalKey<FormState>();

  await BottomSheets.normal(
    context: context,
    title: 'Alterar meta diária',
    content: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.small2,
        vertical: Spacing.medium,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: Spacing.small1),
            DigitOnlyTextField(
              suffix: 'ml',
              label: 'Meta diária',
              maxLength: 5,
              autofocus: true,
              onChanged: (value) {
                amount = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira uma meta diária.';
                }

                return null;
              },
            ),
            const SizedBox(height: Spacing.small2),
            Button.ok(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await onOk(amount!);
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
