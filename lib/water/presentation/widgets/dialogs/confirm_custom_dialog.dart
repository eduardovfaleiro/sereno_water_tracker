// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class ConfirmCustomDialog extends StatelessWidget {
  final String title;
  final String text;

  final Widget actions;

  const ConfirmCustomDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      title: Center(child: Text(title)),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.small1),
        child: Text(text),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(height: 0, thickness: 1, color: MyColors.darkGrey1),
            actions,
          ],
        ),
      ],
    );
  }
}
