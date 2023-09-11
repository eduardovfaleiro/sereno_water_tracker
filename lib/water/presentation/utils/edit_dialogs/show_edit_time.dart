import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/time_picker.dart';
import '../bottom_sheets.dart';

Future<void> showEditTime({
  required BuildContext context,
  required String title,
  required Function(TimeOfDay timeOfDay) onOk,
  required TimeOfDay timeOfDay,
}) async {
  TimeOfDay newTimeOfDay = TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute);

  BottomSheets.normal(
    context: context,
    title: title,
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
            height: MediaQuery.of(context).size.height * .3,
            child: TimePicker(
              initialTime: timeOfDay,
              onHourChanged: (value) {
                newTimeOfDay = value;
              },
              onMinuteChanged: (value) {
                newTimeOfDay = value;
              },
            ),
          ),
          Button.ok(onPressed: () {
            onOk(newTimeOfDay);
          }),
        ],
      ),
    ),
  );
}
