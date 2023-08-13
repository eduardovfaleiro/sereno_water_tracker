import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class CircularButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Widget? label;
  final Color backgroundColor;
  final EdgeInsets contentPadding;

  const CircularButton({
    super.key,
    required this.child,
    required this.onTap,
    this.label,
    this.backgroundColor = MyColors.lightGrey,
    this.contentPadding = const EdgeInsets.all(Spacing.small2),
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(90),
          onTap: () => onTap(),
          onLongPress: () {
            if (onLongPress != null) onLongPress!();
          },
          child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: contentPadding,
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
