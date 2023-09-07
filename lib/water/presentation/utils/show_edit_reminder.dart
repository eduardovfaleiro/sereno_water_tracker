import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';
import '../widgets/buttons/button.dart';
import '../widgets/time_picker.dart';
import 'bottom_sheets.dart';

Future<void> showEditReminder({
  required BuildContext context,
  required Function(TimeOfDay reminder) onOk,
  required TimeOfDay reminder,
}) async {
  TimeOfDay newReminder = TimeOfDay(hour: reminder.hour, minute: reminder.minute);

  BottomSheets.normal(
    context: context,
    title: 'Alterar lembrete',
    content: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: Spacing.small3,
        right: Spacing.small3,
        bottom: Spacing.small3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: TimePicker(
              initialTime: reminder,
              onHourChanged: (value) {
                newReminder = value;
              },
              onMinuteChanged: (value) {
                newReminder = value;
              },
            ),
          ),
          Button.ok(onPressed: () {
            onOk(newReminder);
          }),
        ],
      ),
    ),
  );
}
