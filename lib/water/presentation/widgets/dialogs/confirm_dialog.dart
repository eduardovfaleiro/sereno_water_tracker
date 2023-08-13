// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';
import '../buttons/button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String text;

  final VoidCallback onNo;
  final VoidCallback onYes;

  final String? confirmText;
  final String? cancelText;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.onNo,
    required this.onYes,
    this.confirmText,
    this.cancelText,
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
          children: [
            const Divider(height: 0, thickness: 1, color: MyColors.darkGrey1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Button.cancel(onPressed: () => onNo(), text: cancelText ?? 'Ainda não'),
                ),
                const SizedBox(width: Spacing.small),
                Expanded(
                  child: Button.confirm(
                      onPressed: () {
                        onYes();

                        Navigator.pop(context);
                      },
                      text: confirmText ?? 'Sim, continuar'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
