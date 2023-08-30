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

  late TimeOfDay _timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderController>(
      builder: (context, controller, _) {
        return SafeArea(
          child: Container(
            child: ListView.builder(
              itemCount: controller.reminders.length,
              itemBuilder: (context, index) {
                TimeOfDay reminder = controller.reminders[index];

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
                                      _timeOfDay = value;
                                    },
                                    onMinuteChanged: (value) {
                                      _timeOfDay = value;
                                    },
                                  ),
                                ),
                                Button.ok(onPressed: () async {
                                  await controller.update(key: reminder, newValue: _timeOfDay);
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
                    const Divider(height: 0, thickness: 1, color: MyColors.darkGrey),
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
