// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/reminder_controller.dart';
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
