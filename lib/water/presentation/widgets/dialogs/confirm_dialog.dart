import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';
import '../button.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onNo;
  final VoidCallback onYes;

  const ConfirmDialog({super.key, required this.onNo, required this.onYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      title: const Center(child: Text('Salvar dados?')),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: Spacing.small1),
        child: Text('Você poderá mudar essas alterações.'),
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
                  child: Button.cancel(onPressed: () => onNo(), text: 'Ainda não'),
                ),
                const SizedBox(width: Spacing.small),
                Expanded(
                  child: Button.confirm(onPressed: () => onYes(), text: 'Sim, continuar'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
