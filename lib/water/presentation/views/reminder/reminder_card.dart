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
          Text(TimeOfDayUtils(reminder).toLiteral()),
          Row(
            children: [
              const VerticalDivider(
                width: 0,
                thickness: 1,
                color: Colors.amber,
                indent: 20,
                endIndent: 0,
              ),
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
