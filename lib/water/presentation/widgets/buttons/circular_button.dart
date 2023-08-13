import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class CircularButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Widget? label;
  final Color backgroundColor;

  const CircularButton({
    super.key,
    required this.child,
    required this.onTap,
    this.label,
    this.backgroundColor = MyColors.lightGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(90),
          onTap: () => onTap(),
          child: Ink(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: const EdgeInsets.all(Spacing.small2),
              child: child),
        ),
        if (label != null)
          Column(
            children: [
              const SizedBox(height: Spacing.small),
              label!,
            ],
          ),
      ],
    );
  }
}
