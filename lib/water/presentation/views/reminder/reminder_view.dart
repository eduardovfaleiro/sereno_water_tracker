// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/reminder_controller.dart';
import '../../utils/bottom_sheets.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/time_picker.dart';
import 'reminder_card.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  void initState() {
    super.initState();

    context.read<ReminderController>().init();
  }

  late TimeOfDay _newReminder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderController>(
      builder: (context, controller, _) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: Spacing.huge,
              left: Spacing.small2,
              right: Spacing.small2,
            ),
            child: ListView.builder(
              itemCount: controller.reminders.length,
              itemBuilder: (context, index) {
                TimeOfDay reminder = controller.reminders[index];
                _newReminder = TimeOfDay(hour: reminder.hour, minute: reminder.minute);

                return Column(
                  children: [
                    ReminderCard(
                      reminder,
                      onEdit: () {
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
                                      _newReminder = value;
                                    },
                                    onMinuteChanged: (value) {
                                      _newReminder = value;
                                    },
                                  ),
                                ),
                                Button.ok(onPressed: () async {
                                  await controller.update(key: reminder, newValue: _newReminder);
                                  Navigator.pop(context);
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        controller.delete(timeToDrink: reminder, context: context);
                      },
                    ),
                    const SizedBox(height: Spacing.small1),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
