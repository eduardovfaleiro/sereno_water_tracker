import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/time_of_day_utils.dart';
import '../../../../core/theme/themes.dart';

class ReminderCard extends StatelessWidget {
  final TimeOfDay reminder;
  final Function() onDelete;
  final Function() onEdit;

  const ReminderCard(this.reminder, {super.key, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.darkGrey,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      padding: const EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.small3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.timer, size: Spacing.normal, color: Color.fromARGB(255, 107, 107, 107)),
              const SizedBox(width: Spacing.small1),
              Text(TimeOfDayUtils(reminder).toLiteral()),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.pencil, color: MyColors.lightGrey),
                padding: EdgeInsets.zero,
                onPressed: () {
                  onEdit();
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
        ],
      ),
    );
  }
}
