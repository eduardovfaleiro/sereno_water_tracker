// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/functions/datetime_to_timeofday.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/reminder_controller.dart';
import '../../utils/edit_dialogs/show_edit_time.dart';
import '../../utils/snackbar_message.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderController>(
      builder: (context, controller, _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showEditTime(
                context: context,
                title: 'Adicionar lembrete',
                onOk: (reminder) async {
                  controller.add(reminder: reminder, context: context);

                  Navigator.pop(context);
                },
                timeOfDay: DateTime.now().toTimeOfDay(),
              );
            },
            backgroundColor: MyColors.lightBlue,
            child: const Icon(Icons.add, color: Colors.black),
          ),
          body: SafeArea(
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

                  return Column(
                    children: [
                      ReminderCard(
                        reminder,
                        onEdit: (newReminder) async {
                          await controller.update(key: reminder, newValue: newReminder);

                          SnackBarMessage.undo(
                            context: context,
                            text: 'Lembrete alterado',
                            onPressed: () {},
                          );

                          Navigator.pop(context);
                        },
                        onDelete: () async {
                          await controller.delete(timeToDrink: reminder, context: context);
                        },
                      ),
                      const SizedBox(height: Spacing.small1),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
