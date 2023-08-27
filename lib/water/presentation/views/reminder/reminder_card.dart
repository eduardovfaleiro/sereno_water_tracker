import 'package:flutter/material.dart';

import '../../../../core/functions/time_of_day_utils.dart';
import '../../../../core/theme/themes.dart';

class ReminderCard extends StatelessWidget {
  final TimeOfDay reminder;
  final Function() onDelete;

  const ReminderCard(this.reminder, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.small1, horizontal: Spacing.small3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(TimeOfDayUtils(reminder).toLiteral()),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: MyColors.lightGrey),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: MyColors.lightGrey),
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
