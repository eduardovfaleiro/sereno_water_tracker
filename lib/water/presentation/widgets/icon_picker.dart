import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';
import 'button.dart';

class IconPicker extends StatelessWidget {
  final List<IconData> icons;

  const IconPicker({super.key, required this.icons});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        spacing: Spacing.small1,
        children: List.generate(
          icons.length,
          (index) {
            return InkWell(
              onTap: () {}, // TODO: continuar
              child: Container(
                padding: const EdgeInsets.all(Spacing.small1),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 34, 34, 39),
                  borderRadius: BorderRadius.circular(Spacing.small3),
                ),
                child: Icon(icons[index], size: Spacing.medium2),
              ),
            );
          },
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Button.ok(onPressed: () {}),
        ),
      ],
    );
  }
}
