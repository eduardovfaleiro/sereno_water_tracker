import 'package:flutter/material.dart';

import '../../../../../core/theme/themes.dart';

class CircularButton extends StatelessWidget {
  final Widget child;
  final Text? label;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsets? contentPadding;

  const CircularButton({
    super.key,
    required this.child,
    this.label,
    this.onLongPress,
    this.onTap,
    this.color,
    this.contentPadding = const EdgeInsets.all(Spacing.small3),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(90),
          onLongPress: onLongPress,
          onTap: onTap,
          child: Ink(
            padding: contentPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: color,
            ),
            child: Center(child: child),
          ),
        ),
        const SizedBox(height: Spacing.small),
        label ?? const SizedBox.shrink(),
      ],
    );
  }
}
