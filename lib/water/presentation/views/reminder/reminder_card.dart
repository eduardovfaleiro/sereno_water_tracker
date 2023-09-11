import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/time_of_day_utils.dart';
import '../../../../core/theme/themes.dart';
import '../../utils/edit_dialogs/show_edit_time.dart';

class ReminderCard extends StatelessWidget {
  final TimeOfDay reminder;
  final Function() onDelete;
  final Function(TimeOfDay reminder) onEdit;

  const ReminderCard(this.reminder, {super.key, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyColors.darkGrey,
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timer, size: Spacing.normal, color: MyColors.lightGrey2),
                  const SizedBox(width: Spacing.small2),
                  Text(TimeOfDayUtils(reminder).toLiteral()),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 2)),
                ),
                padding: const EdgeInsets.only(left: Spacing.small3, top: Spacing.small, bottom: Spacing.small),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.pencil, color: MyColors.lightGrey),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showEditTime(
                          title: 'Alterar lembrete',
                          context: context,
                          onOk: (newReminder) {
                            onEdit(newReminder);
                          },
                          timeOfDay: reminder,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.delete, color: MyColors.lightGrey),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        onDelete();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
